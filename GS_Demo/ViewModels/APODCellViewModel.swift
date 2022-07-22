//
//  APODCellViewModel.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 22/07/22.
//

import Foundation
import UIKit

enum PostType {
    case photoCell
    case otherCell
}

class APODCellViewModel {
    var post: PictureDetails
    
    var type: PostType {
        return post.mediaType == "image" ? .photoCell : .otherCell
    }
    
    init(post: PictureDetails) {
        self.post = post
    }
    
    func getCurrentFavoriteStatus() -> Bool {
        return post.isFavorite
    }
    
    func fetchCellImage(completion: @escaping ((UIImage?, Bool) -> Void)) {
        ImageManager.shared.downloadImage(with: post.url, completionHandler: { img, success in
            completion(img, success)
        }, placeholderImage: UIImage(named: "placeholder"))
    }
}
