//
//  PictureDetailsModel.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import Foundation
import CoreData

// MARK: - CoreDataEntity

enum CoreDataEntity: String {
    case postDetails = "PostDetails"
}

// MARK: - PictureDetails

struct PictureDetails: Codable {
    let date, explanation: String?
    let hdurl: String?
    let mediaType, serviceVersion, title: String?
    let url: String?
    var isFavorite = false

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
    
    mutating func toggleFavorite() {
        self.isFavorite.toggle()
    }
}

extension PictureDetails: ManagedObjectConvertible {
    /**
   Method to convert picture detail instance to managed object for core data.
    - Parameter context: Core data context
    */
    func toManagedObject(in context: NSManagedObjectContext) -> PictureDetailsManagedObject? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: CoreDataEntity.postDetails.rawValue, in: context) else {
                  return nil
              }
        let object = PictureDetailsManagedObject.init(entity: entityDescription, insertInto: context)
        object.title = title
        object.explanation = explanation
        object.url = url
        object.hdurl = hdurl
        object.date = date?.getDate()
        object.media_type = mediaType
        object.service_version = serviceVersion
        object.isFavorite = isFavorite
        return object
    }
}
