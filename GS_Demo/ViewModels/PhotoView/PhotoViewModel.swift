//
//  PhotoViewModel.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 24/07/22.
//

import Foundation
import UIKit


protocol PhotoViewModelEntity {
    var pictureDetails: PictureDetails? { get set }
    var refreshUI: (() -> ())? { get set }
    var toggleLoadingStatus: ((Bool, String) -> ())? { get set }
    var currentImage: UIImage? { get }
    func loadPhotoView()
    func closePhotoView()
}

// MARK: - UserResponseListVM

class PhotoViewModel: PhotoViewModelEntity {
    
    private(set) var currentImage = GlobalConstants.placeholderImage {
        didSet {
            refreshUI?()
        }
    }
    
    var pictureDetails: PictureDetails? {
        didSet {
            loadPhotoView()
        }
    }
    
    var toggleLoadingStatus: ((Bool, String) -> ())?
    var refreshUI: (() -> ())?
    
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
    
    func closePhotoView() {
        NavigationRouter.shared.dismissFromPhotoDetails()
    }
}
