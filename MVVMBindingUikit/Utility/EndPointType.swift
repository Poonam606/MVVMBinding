//
//  EndPointType.swift
//  MVVMBindingUikit
//
//  Created by poonam on 03/05/25.
//

import Foundation
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    
}

protocol EndPointType {
    var path: String{get}
    var baseUrl : String { get }
    var url: URL? { get }
    var method: HTTPMethod { get}
}
enum Endpointitems {
    case products
}
extension Endpointitems : EndPointType {
    var path: String {
        return "products"
    }
    
    var baseUrl: String {
        return "https://fakestoreapi.com/"
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HTTPMethod {
        switch self {
        case .products:
            return .get
            
        }
    }
    
    
}
