//
//  CountryRepository.swift
//  CoreDataCountry
//
//  Created by Aldair Raul Cosetito Coral on 9/29/20.
//

import CoreData

struct CountryRepository {
    
    func getAll(context: NSManagedObjectContext) -> [Country]{
        return Country.fetchCountries(context: context)
    }
    
    func saveCountry(id: String, name: String, context: NSManagedObjectContext) {
        Country.save(id: id, name: name, context: context)
    }
    
}
