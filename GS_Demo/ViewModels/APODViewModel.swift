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
    var refreshUI: (()->())? { get set }
    var showAlert: ((String?)->())? { get set }
    var toggleLoadingStatus: ((_ isLoading: Bool)->())? { get set}
}

// MARK: - UserResponseListVMEntity

protocol APODViewModelEntity: ViewModelOveservers {
    var totalCells: Int { get }
    func getCellViewModel(at indexPath: IndexPath) -> APODCellViewModel
    func initialise()
}

// MARK: - UserResponseListVM

class APODViewModel: APODViewModelEntity {
    
    var refreshUI: (() -> ())?
    var showAlert: ((String?) -> ())?
    var toggleLoadingStatus: ((Bool) -> ())?
    
    private var alertMessage: String? {
        didSet {
            self.showAlert?(alertMessage)
        }
    }
    
    private var isLoading = false {
        didSet {
            self.toggleLoadingStatus?(isLoading)
        }
    }
    
    private(set) var allCellVMs: [APODCellViewModel] = [APODCellViewModel]() {
        didSet {
            self.refreshUI?()
        }
    }
    
    var totalCells: Int {
        return allCellVMs.count
    }
    
    private var selectedDate: Date? {
        didSet {
            self.toggleLoadingStatus?(isLoading)
            self.fetchPictureData()
        }
    }
    
    private var isFavoriteMode: Bool = true {
        didSet {
            self.toggleLoadingStatus?(isLoading)
            self.fetchPictureData()
        }
    }
    
    private(set) var apiService: GSAPIServiceEntity?
    
    // MARK: - Static Scope

    // MARK: - Internal Scope

    let coreDataManager: CoreDataManagerEntity
    
    init(coreDataService: CoreDataManagerEntity = CoreDataManager(modelName: "GS_Demo")) {
        self.coreDataManager = coreDataService
    }
    
    func initialise() {
        self.isLoading = true
        if let url = URL(string: NetworkingConstants.baseURL) {
            apiService = GSAPIServices(baseUrl: url)
        }
        refreshData()
    }
    
    func refreshData() {
        if isFavoriteMode {
            fetchFavoritePictures()
        } else {
            fetchPictureData()
        }
    }
    
    private func fetchPictureData() {
        guard let date = selectedDate else {
                allCellVMs.removeAll()
            return
        }
        
        apiService?.fetchAPODDetails(date: date , completion: { [weak self] postResult in
            switch postResult {
            case .success(let post):
                self?.processPost(post: post)
            case .failure(let error):
                break
            }
        })
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> APODCellViewModel {
        return allCellVMs[indexPath.row]
    }
    
    func getCellViewModel(title: String) -> APODCellViewModel? {
        return allCellVMs.first(where: { $0.post.title == title })
    }
    
    private func fetchFavoritePictures() {
        let pictures = coreDataManager.retriveFavouriteAPOD(true, sortAscending: true)
        var vms = [APODCellViewModel]()
        
        for picture in pictures {
            let cellVM = APODCellViewModel(post: picture)
            vms.append(cellVM)
        }
        
        allCellVMs = vms
    }
    
    private func processPost(post: PictureDetails) {
        let cellVM = APODCellViewModel(post: post)
        allCellVMs.append(cellVM)
    }
}

