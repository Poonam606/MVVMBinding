//
//  ApiManager.swift
//  MVVMBindingUikit
//
//  Created by poonam on 28/03/25.
//

import Foundation
import UIKit
enum DataError : Error{
    case invaildResponse
    case invalidUrl
    case invalidData
    case networkError
    case message(_ error: Error)
}

typealias ResultHandler<T: Decodable> = (Result<T,DataError>) -> Void
typealias Handler = (Result<[ProductModel],DataError>) -> Void
final class ApiManager {
    static let shared =  ApiManager ()
    private init(){
        
    }
    func requeste<T>(modelType: T.Type,type: EndPointType,completion: @escaping ResultHandler<T>) {
        guard let url = type.url else {
            completion (.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response,error  in
            guard let data, error == nil else {
                return completion(.failure(.invaildResponse))
            }
            print("response",response)
            guard let response = response as? HTTPURLResponse, 200...209 ~= response.statusCode else  {
                completion(.failure(.invaildResponse))
                return
            }
            do {
                let product =  try JSONDecoder().decode(modelType, from: data)
                completion(.success(product))
                
            } catch {
                completion(.failure(.message(error)))
            }
            
        }.resume()
        
    }
    
    func fetchProducts(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.productURL) else {
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response,error) in
            guard let data , error == nil else{
                completion(.failure(.invaildResponse))
                return
            }
            guard let response = response as? HTTPURLResponse, 200...209 ~= response.statusCode else {
                return
            }
            do {
                let product = try JSONDecoder().decode([ProductModel].self, from: data)
                completion(.success(product))
            } catch {
                completion(.failure(.message(error)))
            }
            
        }
        guard let url = URL(string: Constant.API.productURL) else {
            completion(.failure(.invalidUrl)) // Add missing error handling for invalid URL
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                completion(.failure(.invaildResponse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([ProductModel].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(.message(error))) // More informative error
            }
        }.resume() // ← You forgot to resume the task!
    }
    
}
