//
//  CoreDataManager.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 21/07/22.
//

import CoreData

// MARK: - CoreDataManagerEntity

protocol CoreDataManagerEntity {
    func saveAPODData(postDetail: PictureDetails) -> PictureDetails?
    func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void))
    func getAllRecentPosts(_ sortedByDate: Bool, sortAscending: Bool) -> [PictureDetails]
    func retriveFavouriteAPOD(_ sortedByDate: Bool,  sortAscending: Bool) -> [PictureDetails]
}

// MARK: - CoreDataManager

final class CoreDataManager: CoreDataManagerEntity {

    // MARK: - Properties

    private let modelName: String

    // MARK: - Initialization

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Core Data Stack

    private lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"

        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    /**
        Save individual pictureDetails
        parameters:
        
        - Parameter postDetail: Picture to save
    */
    func saveAPODData(postDetail: PictureDetails) -> PictureDetails? {
        let childContex = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        childContex.parent = managedObjectContext
        var curretObject: PictureDetailsManagedObject?

        childContex.performAndWait { [weak self] in
            guard !childContex.hasChanges else {
                try? self?.saveWorkerContex(workerContex: childContex)
                return
            }
            // Check for update operation
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntity.postDetails.rawValue)
            let predicate = NSPredicate(format: "title = %@", postDetail.title ?? "")
            fetchRequest.predicate = predicate
            
            do {
                if let result = try childContex.fetch(fetchRequest) as? [PictureDetailsManagedObject],
                   let obj = result.first {
                    curretObject = obj
                    curretObject?.url = postDetail.url
                    curretObject?.hdurl = postDetail.hdurl
                    curretObject?.explanation = postDetail.explanation
                    curretObject?.date = postDetail.date?.getDate()
                } else {
                    curretObject = postDetail.toManagedObject(in: childContex)
                }
                try self?.saveWorkerContex(workerContex: childContex)
            } catch let fetchError as NSError {
                print("retrieveById error: \(fetchError.localizedDescription)")
            }
        }
        return curretObject?.toDomainObject()
        
    }
    
    /**
        Change favorite flag for particular pictureDetails
        parameters:
        
        - Parameter isFavorite: Bool flag to indicate status of favorite
        - Parameter postDetail: Post to update favorite status
    */
    func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void)) {
        let childContex = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        childContex.parent = managedObjectContext
        
        childContex.performAndWait { [weak self] in
            guard !childContex.hasChanges else {
                try? self?.saveWorkerContex(workerContex: childContex)
                completion(false)
                return
            }
            
            // Check for update operation
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntity.postDetails.rawValue)
            let predicate = NSPredicate(format: "title = %@", postDetail.title ?? "")
            fetchRequest.predicate = predicate
            
            do {
                if let result = try childContex.fetch(fetchRequest) as? [PictureDetailsManagedObject],
                   let obj = result.first {
                    obj.isFavorite = isFavorite
                    print(obj)
                }
                try self?.saveWorkerContex(workerContex: childContex)
                completion(true)
            } catch let fetchError as NSError {
                print("retrieveById error: \(fetchError.localizedDescription)")
                completion(false)
            }
        }
    }
    
    private func saveWorkerContex(workerContex: NSManagedObjectContext) throws {
        do {
            try workerContex.save()
            try self.managedObjectContext.save()
        } catch {
            let saveError = error as NSError
            print("Unable to Save Changes")
            print("\(saveError), \(saveError.localizedDescription)")
        }
    }
    
    /**
        Retrieves all favourite pictureDetails items stored in the persistence layer, default (overridable)
        parameters:
        
        - Parameter sortedByDate: Bool flag to add sort rule: by Date
        - Parameter sortAscending: Bool flag to set rule on sorting: Ascending / Descending date.
    
        - Returns: [PictureDetails] with found photoDetails in datastore
    */
    func retriveFavouriteAPOD(_ sortedByDate: Bool = true,  sortAscending: Bool = true) -> [PictureDetails] {
        var fetchedResults = [PictureDetailsManagedObject]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntity.postDetails.rawValue)
        
        if sortedByDate {
            let sortDescriptor = NSSortDescriptor(key: "date",
                                                  ascending: sortAscending)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        let predicate = NSPredicate(format: "isFavorite = %d", true)
        fetchRequest.predicate = predicate
        
        do {
            fetchedResults = try self.managedObjectContext.fetch(fetchRequest) as? [PictureDetailsManagedObject] ?? []
        } catch let fetchError as NSError {
            print("retrieveById error: \(fetchError.localizedDescription)")
            fetchedResults = [PictureDetailsManagedObject]()
        }
        print(fetchedResults)
        return fetchedResults.map {
            $0.toDomainObject()
        }
    }
    
    /**
        Retrieves all recent pictureDetails items stored in the persistence layer, default (overridable)
        parameters:
        
        - Parameter sortedByDate: Bool flag to add sort rule: by Date
        - Parameter sortAscending: Bool flag to set rule on sorting: Ascending / Descending date.
    
        - Returns: [PictureDetails] with found photoDetails in datastore
    */
    func getAllRecentPosts(_ sortedByDate: Bool = true, sortAscending: Bool = true) -> [PictureDetails] {
        var fetchedResults = [PictureDetailsManagedObject]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntity.postDetails.rawValue)
        
        if sortedByDate {
            let sortDescriptor = NSSortDescriptor(key: "date",
                                                  ascending: sortAscending)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        do {
            fetchedResults = try self.managedObjectContext.fetch(fetchRequest) as? [PictureDetailsManagedObject] ?? []
        } catch let fetchError as NSError {
            print("retrieveById error: \(fetchError.localizedDescription)")
            fetchedResults = [PictureDetailsManagedObject]()
        }
        
        return fetchedResults.map {
            $0.toDomainObject()
        }
    }
}
