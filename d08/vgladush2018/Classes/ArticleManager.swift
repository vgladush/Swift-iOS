//
//  ArticleManager.swift
//  vgladush2018
//
//  Created by Vyacheslav GLADUSH on 12.10.2018.
//

import CoreData

public class ArticleManager: NSObject {
    
    var managedObjectContext : NSManagedObjectContext
    var commitPredicate: NSPredicate?
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
    
    public override init() {
        let myBundle = Bundle(identifier: "org.cocoapods.vgladush2018")
        guard let modelURL = myBundle?.url(forResource: "article", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let storeURL = docURL?.appendingPathComponent("vgladush2018.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    public func newArticle () -> Article {
        return NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjectContext) as! Article
    }
    
    func loadData() -> [Article] {
        request.predicate = commitPredicate
        do {
            let result = try managedObjectContext.fetch(request) as! [Article]
            return result
        }catch{
            fatalError("Failed to fetch arts")
        }
        commitPredicate = nil
    }
    
    public func getAllArticles() -> [Article] {
        commitPredicate = NSPredicate(value: true)
        return loadData()
    }
    
    public func  getArticles(withLang lang : String) -> [Article] {
        commitPredicate = NSPredicate(format: "language == %@", lang)
        return loadData()
    }
    
    public func getArticles(containString str : String) -> [Article] {
        commitPredicate = NSPredicate(format: "title CONTAINS %@ || content CONTAINS %@", str, str)
        return loadData()
    }
    
    public func removeArticle(article : Article) {
        managedObjectContext.delete(article)
    }
    
    public func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            }
            catch{
                fatalError("Fail to save content \(error)");
            }
        }
    }
}
