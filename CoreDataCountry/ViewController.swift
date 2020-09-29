//
//  ViewController.swift
//  CoreDataCountry
//
//  Created by Aldair Raul Cosetito Coral on 9/28/20.
//

import UIKit

class ViewController: UIViewController {

    let countryRepository = CountryRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let service = CountryService()
//        service.getCountries()
        
        let countriesDB = countryRepository.getAll(context: ContextManager.shared.context)
        
        for country in countriesDB {
            print("\(country.id) - \(country.name)")
        }
    }


}

