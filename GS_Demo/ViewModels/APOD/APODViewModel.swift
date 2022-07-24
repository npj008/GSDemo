//
//  APODViewModel.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 22/07/22.
//

import Foundation
import UIKit

// MARK: - ViewModelOveservers

protocol ViewModelOveservers {
    var toggleLoadingStatus: ((Bool, String) -> ())? { get set}
    var refreshUI: (()->())? { get set }
    var resetUI: (()->())? { get set }
    var showAlert: ((String?)->())? { get set }
}

// MARK: - UserResponseListVMEntity

protocol APODViewModelEntity: ViewModelOveservers,
                              FavoritablePictureProtocol {
    var totalCells: Int { get }
    var selectedDate: Date? { get }
    var currentMode: APODViewModelStete { get }
    func getCellViewModel(at indexPath: IndexPath) -> APODCellViewModel
    func initialise()
    func setCurrentMode(mode: APODViewModelStete)
    func cleanupCache(completion: @escaping (() -> Void))
    func playVideo(url: URL)
    func expandImage(postDetails: PictureDetails)
}

enum APODViewModelStete {
    case favorite
    case search(date: Date?)
}

// MARK: - UserResponseListVM

class APODViewModel: APODViewModelEntity {
    
    func setCurrentMode(mode: APODViewModelStete) {
        self.currentMode = mode
    }
    
    private(set) var currentMode: APODViewModelStete = .search(date: nil) {
        didSet {
            refreshData()
        }
    }
    
    var refreshUI: (() -> ())?
    var resetUI: (() -> ())?
    var showAlert: ((String?) -> ())?
    var toggleLoadingStatus: ((Bool, String) -> ())?
    
    lazy private var processQueue: DispatchQueue = {
        let queue = DispatchQueue(label: "processQueue", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        return queue
    }()
    
    private var alertMessage: String? {
        didSet {
            self.showAlert?(alertMessage)
        }
    }
    
    private var isLoading = false {
        didSet {
            self.toggleLoadingStatus?(isLoading, "Refreshing Data....")
        }
    }
    
    private(set) var allCellVMs: [APODCellViewModel] = [APODCellViewModel]() {
        didSet {
            self.refreshUI?()
            self.isLoading = false
        }
    }
    
    var totalCells: Int {
        return allCellVMs.count
    }
    
    private(set) var selectedDate: Date?

    private(set) var apiService: GSAPIServiceEntity?
    
    // MARK: - Static Scope

    // MARK: - Internal Scope

    let coreDataManager: CoreDataManagerEntity
    
    init(coreDataService: CoreDataManagerEntity = CoreDataManager(modelName: "GS_Demo")) {
        self.coreDataManager = coreDataService
    }
    
    func initialise() {
        if let url = URL(string: NetworkingConstants.baseURL) {
            apiService = GSAPIServices(baseUrl: url)
        }
        refreshData()
    }
    
    private func refreshData() {
        switch currentMode {
        case .favorite:
            self.processQueue.async(flags: .barrier) { [weak self] in
                self?.fetchFavoritePictures()
            }
        case .search(let date):
            self.processQueue.async(flags: .barrier) { [weak self] in
                self?.selectedDate = date
                self?.fetchPictureData()
            }

        }
    }
    
    
    private func fetchPictureData() {
        guard let date = selectedDate else {
                allCellVMs.removeAll()
            return
        }
        
        self.isLoading = true
        apiService?.fetchAPODDetails(date: date , completion: { [weak self] postResult in
            switch postResult {
            case .success(let post):
                self?.processPost(post: post)
            case .failure(let error):
                print(error.localizedDescription)
                self?.alertMessage = error.localizedDescription
                self?.resetUI?()
            }
            self?.isLoading = false
        })
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> APODCellViewModel {
        return allCellVMs[indexPath.row]
    }
    
    func getCellViewModel(title: String) -> APODCellViewModel? {
        return allCellVMs.first(where: { $0.post.title == title })
    }
    
    private func fetchFavoritePictures() {
        self.isLoading = true
        let pictures = coreDataManager.retriveFavouriteAPOD(true, sortAscending: false)
        var vms = [APODCellViewModel]()
        
        for picture in pictures {
            let cellVM = APODCellViewModel(post: picture)
            vms.append(cellVM)
        }
        
        allCellVMs = vms
        isLoading = false
    }
    
    func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void)) {
        self.processQueue.async(flags: .barrier) { [weak self] in
            self?.coreDataManager.toggleFavorite(isFavorite: isFavorite,
                                           postDetail: postDetail) { success in
                completion(success)
            }
        }
    }
    
    func playVideo(url: URL) {
        NavigationRouter.shared.openURLExternally(url: url)
    }
    
    func expandImage(postDetails: PictureDetails) {
        NavigationRouter.shared.navigateToPhotoDetails(photoDetails: postDetails)
    }
    
    private func processPost(post: PictureDetails) {
        self.processQueue.async(flags: .barrier) { [weak self] in
            let object = self?.coreDataManager.saveAPODData(postDetail: post) ?? post
            self?.allCellVMs = [APODCellViewModel(post: object)]
        }
    }
    
    func cleanupCache(completion: @escaping (() -> Void)) {
        ImageManager.shared.cleanupCache {
            completion()
        }
    }
}
