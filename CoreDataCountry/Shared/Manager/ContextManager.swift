//
//  ContextManager.swift
//  CoreDataCountry
//
//  Created by Aldair Raul Cosetito Coral on 9/28/20.
//

import CoreData

struct ContextManager {
    
    static let shared = ContextManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "WorldCountry")
        container.loadPersistentStores { (description, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error) \(error.userInfo)")
            }
        }
        self.context = container.viewContext
    }
    
}
