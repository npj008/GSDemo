//
//  APODCellViewModel.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 22/07/22.
//

import Foundation
import UIKit

// MARK: - PostType

enum PostType: String {
    case photoCell = "image"
    case videoCell = "video"
    case otherCell
}

// MARK: - APODCellViewModel

class APODCellViewModel {
    var post: PictureDetails
    
    /// Returns current type
    var type: PostType {
        return PostType(rawValue: post.mediaType ?? "") ?? .otherCell
    }
    
    init(post: PictureDetails) {
        self.post = post
    }
    
    /// Method to get current favorite status
    func getCurrentFavoriteStatus() -> Bool {
        return post.isFavorite
    }
    
    /**
   Method to load image from remote server and cache it.
    - Parameter completion: completion returning image instance and status of completion
    */
    func fetchCellImage(completion: @escaping ((UIImage?, Bool) -> Void)) {
        ImageManager.shared.downloadImage(with: post.url, completionHandler: { img, success in
            completion(img, success)
        }, placeholderImage: GlobalConstants.placeholderImage)
    }
}
