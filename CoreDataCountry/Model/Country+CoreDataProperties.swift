//
//  Country+CoreDataProperties.swift
//  CoreDataCountry
//
//  Created by Aldair Raul Cosetito Coral on 9/28/20.
//

import CoreData

extension Country{
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    
    static func fetchCountries(context: NSManagedObjectContext) -> [Country]{
        let request = NSFetchRequest<Country>.init(entityName: "Country")
        let result = try? context.fetch(request)
        return result ?? []
    }
    
    static func save(id: String, name: String, context: NSManagedObjectContext){
        let country = Country(context: context)
        country.id = id
        country.name = name
        do {
            try context.save()
        } catch {
            fatalError("Unresolved CoreData - \(error) \(error.localizedDescription)")
        }
    }
}
