//
//  RestAPI.swift
//  CoreDataCountry
//
//  Created by Aldair Raul Cosetito Coral on 9/28/20.
//

import Foundation

enum responseAPI<T>{
    case failure(Error)
    case success(T)
}

protocol RestAPI {
    func callService<T:Decodable>(url: String,
                     verb: String,
                     headers: [String: Any]?,
                     data: Data?,
                     objectType: T.Type,
                     completion: @escaping(responseAPI<T>) -> Void)
}

extension RestAPI{
    func callService<T:Decodable>(url: String,
                     verb: String,
                     headers: [String: Any]? = nil,
                     data: Data? = nil,
                     objectType: T.Type,
                     completion: @escaping(responseAPI<T>) -> Void){
        
        guard let serviceUrl = URL(string: url) else{return}
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = verb
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let nsError = error as NSError? {
                fatalError("Unresolved error API \(nsError) - \(nsError.userInfo)")
                completion(.failure(nsError))
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    let decoder = try JSONDecoder().decode(objectType.self, from: data)
                    
                    completion(.success(decoder))
                } catch {
                    fatalError("Unresolved error from convert data \(error) - \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
}
