//
//  RestAPI.swift
//  CoreDataCountry
//
//  Created by Aldair Raul Cosetito Coral on 9/28/20.
//

import Foundation

protocol RestAPI {
    func callService<T:Decodable>(url: String,
                     verb: String,
                     headers: [String: Any]?,
                     data: Data?,
                     objectType: T.Type)
}

extension RestAPI{
    func callService<T:Decodable>(url: String,
                     verb: String,
                     headers: [String: Any]? = nil,
                     data: Data? = nil,
                     objectType: T.Type){
        
        guard let serviceUrl = URL(string: url) else{return}
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = verb
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let nsError = error as NSError? {
                fatalError("Unresolved error API \(nsError) - \(nsError.userInfo)")
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let decoder = try JSONDecoder().decode(objectType.self, from: data)
                    print(decoder)
                } catch {
                    fatalError("Unresolved error from convert data \(error) - \(error.localizedDescription)")
                }
            }
            
        }
        
    }
}
