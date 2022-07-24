//
//  PhotoViewModel.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 24/07/22.
//

import Foundation
import UIKit

// MARK: - PhotoViewModelEntity

protocol PhotoViewModelEntity {
    var pictureDetails: PictureDetails? { get set }
    var refreshUI: (() -> ())? { get set }
    var toggleLoadingStatus: ((Bool, String) -> ())? { get set }
    var currentImage: UIImage? { get }
    func loadPhotoView()
    func closePhotoView()
}

// MARK: - PhotoViewModel

class PhotoViewModel: PhotoViewModelEntity {
    
    // MARK: - Internal Scope
    
    var pictureDetails: PictureDetails? {
        didSet {
            loadPhotoView()
        }
    }
    
    /// Observers for data bindings
    var toggleLoadingStatus: ((Bool, String) -> ())?
    var refreshUI: (() -> ())?
    
    /// Method to load image in full screen view using current picture details
    func loadPhotoView() {
        guard let imgString = pictureDetails?.url else {
            return
        }
        
        toggleLoadingStatus?(true, "fetching photo")
        
        ImageManager.shared.downloadImage(with: imgString, completionHandler: { [weak self] img, success in
            self?.currentImage = img
            self?.toggleLoadingStatus?(false, "")
        }, placeholderImage: GlobalConstants.placeholderImage)
    }
    
    /// Method to pop viewcontroller
    func closePhotoView() {
        NavigationRouter.shared.dismissFromPhotoDetails()
    }
    
    // MARK: - Private Scope

    private(set) var currentImage = GlobalConstants.placeholderImage {
        didSet {
            refreshUI?()
        }
    }
}
