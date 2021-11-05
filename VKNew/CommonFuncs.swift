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
    
    func fetchData(predicate: NSPredicate?) -> [Post] {
        if fetchedResultsController == nil {
            let context = coreDataManager.persistentStoreContainer.viewContext
            let entityDescription = NSEntityDescription.entity(forEntityName: "Post", in: context)
            let request = NSFetchRequest<NSFetchRequestResult>()

            request.entity = entityDescription
            request.predicate = predicate
            request.fetchLimit = 20
            request.fetchBatchSize = 20
            
            let nameSortDescriptor = NSSortDescriptor(key: "author", ascending: true)
            request.sortDescriptors = [nameSortDescriptor]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataManager.persistentStoreContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)

            fetchedResultsController.delegate = self
        }
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetch failed")
        }
        return fetchedResultsController.fetchedObjects as! [Post]
    }
    
    func convertCoreDataPostsToStoragePost(posts: [Post]?) -> [StoragePost] {
        var favoritePosts = [StoragePost]()
        
        guard let postsFromCoreData = posts else {
            return favoritePosts
        }
        for post in postsFromCoreData {
            guard let author = post.author, let title = post.title, let image = post.image, let data = UIImage(data: image) else {
                return favoritePosts
            }
            let pst = StoragePost(author: author, title: title, image: data,
                                  likes: post.likes, views: post.views)
            favoritePosts.append(pst)
        }
        return favoritePosts
    }
}
