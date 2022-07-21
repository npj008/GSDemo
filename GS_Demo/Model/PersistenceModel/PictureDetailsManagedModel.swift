//
//  PictureDetailsManagedModel.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 21/07/22.
//

import Foundation
import CoreData


/// Protocol to provide functionality for Core Data managed object conversion.
protocol ManagedObjectConvertible {
    associatedtype ManagedObject

    /// Converts a conforming instance to a managed object instance.
    ///
    /// - Parameter context: The managed object context to use.
    /// - Returns: The converted managed object instance.
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}

/// Protocol to provide functionality for Domain object conversion from coredata.
protocol DomainObjectConvertible {
    associatedtype DomainObject

    /// Converts a conforming anaged object instance to a domain object instance.
    ///
    /// - Returns: The converted domain object instance.
    func toDomainObject() -> DomainObject
}

class PictureDetailsManagedObject: NSManagedObject {
    
    @NSManaged var date: Date?
    @NSManaged var title: String?
    @NSManaged var explanation: String?
    @NSManaged var url: String?
    @NSManaged var hdurl: String?
    @NSManaged var media_type: String?
    @NSManaged var service_version: String?
    @NSManaged var isRecent: Bool
    @NSManaged var isFavorite: Bool
}

extension PictureDetailsManagedObject: DomainObjectConvertible {    
    func toDomainObject() -> PictureDetails {
        let obj = PictureDetails(date: self.date?.getDateString(),
                                 explanation: self.explanation,
                                 hdurl: self.hdurl,
                                 mediaType: self.media_type,
                                 serviceVersion: self.service_version,
                                 title: self.title,
                                 url: self.url,
                                 isFavorite: self.isFavorite)
        return obj
    }
}
