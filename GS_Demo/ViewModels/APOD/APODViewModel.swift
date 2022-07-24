//
//  APODViewModel.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 22/07/22.
//

import Foundation
import UIKit

// MARK: - PhotoViewMode

enum PhotoViewMode {
    case sd
    case hd
}

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
    var currentPictureQualityMode: PhotoViewMode { get set }
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

// MARK: - APODViewModelStete

enum APODViewModelStete {
    case favorite
    case search(date: Date?)
}

// MARK: - APODViewModel

class APODViewModel: APODViewModelEntity {
    
    // MARK: - Internal Scope
    
    /// Setting this will refresh UI with updated picture quality
    var currentPictureQualityMode: PhotoViewMode {
        get {
            return ImageManager.shared.currentPictureQualityMode
        } set {
            allCellVMs.removeAll()
            ImageManager.shared.currentPictureQualityMode = newValue
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
    
    var totalCells: Int {
        return allCellVMs.count
    }
    
    let coreDataManager: CoreDataManagerEntity
    
    init(coreDataService: CoreDataManagerEntity = CoreDataManager(modelName: "GS_Demo"),
         apiService: GSAPIServiceEntity? = nil) {
        self.coreDataManager = coreDataService
        self.apiService = apiService
    }
    
    /// Initiate viewmodel
    func initialise() {
        if let url = URL(string: NetworkingConstants.baseURL), apiService == nil {
            apiService = GSAPIServices(baseUrl: url)
        }
        refreshData()
    }
    
    func setCurrentMode(mode: APODViewModelStete) {
        self.currentMode = mode
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> APODCellViewModel {
        return allCellVMs[indexPath.row]
    }
    
    func getCellViewModel(title: String) -> APODCellViewModel? {
        return allCellVMs.first(where: { $0.post.title == title })
    }
    
    /**
   To update current favorite state of picture details and cache it locally
    - Parameter isFavorite: Either liked or not
    - Parameter postDetail: Post for which favorite status needs to be changed
    - Parameter completion: Completion handler indicating operation is completed.
    */
    func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void)) {
        self.processQueue.async(flags: .barrier) { [weak self] in
            self?.coreDataManager.toggleFavorite(isFavorite: isFavorite,
                                           postDetail: postDetail) { success in
                completion(success)
                switch self?.currentMode {
                case .favorite:
                    self?.refreshData()
                default:
                    break
                }
            }
        }
    }
    
    /**
   Method for open video url in external browser
    - Parameter url: Video URL
    */
    func playVideo(url: URL) {
        NavigationRouter.shared.openURLExternally(url: url)
    }
    
    /**
   Method for full screen picture view navigation
    - Parameter postDetails: Pincture details for which Image needs to display
    */
    func expandImage(postDetails: PictureDetails) {
        NavigationRouter.shared.navigateToPhotoDetails(photoDetails: postDetails)
    }
    
    /**
   Method to clear local cache data
    - Parameter completion: Completion handler once cleanup task is done
    */
    func cleanupCache(completion: @escaping (() -> Void)) {
        ImageManager.shared.cleanupCache {
            completion()
        }
    }

    // MARK: - Private Scope
    
    /// Holds current mode value
    private(set) var currentMode: APODViewModelStete = .search(date: nil) {
        didSet {
            refreshData()
        }
    }
    
    /// Setting this string will trigger alert on the UI
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
    
    /// Setting this cell VMs will refresh main UI
    private(set) var allCellVMs: [APODCellViewModel] = [APODCellViewModel]() {
        didSet {
            self.refreshUI?()
            self.isLoading = false
        }
    }
    
    private(set) var selectedDate: Date?
    private(set) var apiService: GSAPIServiceEntity?

    /// Refresh data based on current mode (search / favorite)
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
    
    /// Method to fetch individual picture detail from API
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
    
    private func processPost(post: PictureDetails) {
        self.processQueue.async(flags: .barrier) { [weak self] in
            let object = self?.coreDataManager.saveAPODData(postDetail: post) ?? post
            self?.allCellVMs = [APODCellViewModel(post: object)]
        }
    }
    
    /// Method to fetch favorite pictures from local storage
    private func fetchFavoritePictures() {
        allCellVMs.removeAll()
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
}
