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

     var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
     func fetchData(complition: @escaping([Task]) -> Void) {
        let fetchRequest = Task.fetchRequest()
        
        do {
           let taskList = try context.fetch(fetchRequest)
            complition(taskList)
        } catch let error {
            print("Failed to fetch data", error)
        }
    }
    
    func save(_ taskName: String, complition: @escaping(Task) -> Void) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        task.title = taskName
        complition(task)
        saveContext()
    }
    
    private init(){}
}

