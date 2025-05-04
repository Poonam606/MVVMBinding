//
//  ProductModel.swift
//  MVVMBindingUikit
//
//  Created by poonam on 28/03/25.
//

import Foundation
struct ProductModel : Decodable{
    let id : Int
    let title : String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rate
}
struct Rate :Decodable{
    let rate : Double
    let count: Int
}
