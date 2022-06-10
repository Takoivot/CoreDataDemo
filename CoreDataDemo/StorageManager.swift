//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Артур Сахбиев on 10.06.2022.
//

import UIKit
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
     var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private init(){}
}
