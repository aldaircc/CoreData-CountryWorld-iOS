//
//  CountryService.swift
//  CoreDataCountry
//
//  Created by Aldair Raul Cosetito Coral on 9/29/20.
//

import Foundation

struct CountryService: RestAPI {
    
    let countryRepository = CountryRepository()
    let url = "http://country.io/names.json"
    
    func getCountries(){
        callService(url: url,
                    verb: "GET",
                    objectType: [String:String].self) { response in
            switch response{
            case .success(let data):
                
                for element in data {
                    
                    countryRepository.saveCountry(id: element.key,
                                                  name: element.value,
                                                  context: ContextManager.shared.context)
                }
            
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
