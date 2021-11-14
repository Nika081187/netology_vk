//
//  CommonFuncs.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit
import CoreData

class CommonFuncs: NSObject, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    private let coreDataManager = CoreDataStack(modelName: "PostModel")
    
//    func fetchData(predicate: NSPredicate?) -> [Post] {
//        if fetchedResultsController == nil {
//            let context = coreDataManager.persistentStoreContainer.viewContext
//            let entityDescription = NSEntityDescription.entity(forEntityName: "Post", in: context)
//            let request = NSFetchRequest<NSFetchRequestResult>()
//
//            request.entity = entityDescription
//            request.predicate = predicate
//            request.fetchLimit = 20
//            request.fetchBatchSize = 20
//
//            let nameSortDescriptor = NSSortDescriptor(key: "author", ascending: true)
//            request.sortDescriptors = [nameSortDescriptor]
//
//            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataManager.persistentStoreContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//            fetchedResultsController.delegate = self
//        }
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            print("Fetch failed")
//        }
//        return fetchedResultsController.fetchedObjects as! [Post]
//    }
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var persistentStoreContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError()
            }
        }
        return container
    }()
    
    func getContext() -> NSManagedObjectContext {
        persistentStoreContainer.newBackgroundContext()
    }
    
    func fetchData<T: NSManagedObject>(for entity: T.Type, predicate: NSPredicate?) -> [Post] {
        let taskContext = persistentStoreContainer.viewContext
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil

        let entityName = String(describing: T.self)
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate

        do {
            let posts = try taskContext.fetch(request) as! [Post]
            return posts
        } catch {
            fatalError()
        }
    }
    
    func convertCoreDataPostsToStoragePost(posts: [Post]?) -> [StoragePost] {
        var favoritePosts = [StoragePost]()
        
        guard let postsFromCoreData = posts else {
            return favoritePosts
        }
        for post in postsFromCoreData {
            guard let author = post.author, let authorDescription = post.authordescription, let title = post.title, let image = post.image, let data = UIImage(data: image) else {
                return favoritePosts
            }
            let pst = StoragePost(author: author, authorDescription: authorDescription, title: title, image: data,
                                  likes: post.likes, views: post.views)
            favoritePosts.append(pst)
        }
        return favoritePosts
    }
    
    func getInt(text: String) -> Int64 {
        guard let number = Int64(text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) else {
            fatalError()
        }
        return number
    }
}
