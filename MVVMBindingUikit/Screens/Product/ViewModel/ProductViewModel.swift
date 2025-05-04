//
//  ProductViewModel.swift
//  MVVMBindingUikit
//
//  Created by poonam on 01/04/25.
//

import Foundation
final class ProductViewModel {
    var products: [ProductModel] = []
    var eventhandler: ((_ event: Event) -> Void)?
    func fetchProduct(){
        self.eventhandler?(.loading)
        print("Endpointitems.products",Endpointitems.products)
        ApiManager.shared.requeste(modelType: [ProductModel].self, type: Endpointitems.products, completion:  { response in
             self.eventhandler?(.stopLoading)
                 switch response {
                 case .success(let products):
                     print("Products",products)
                    self.products = products
                    self.eventhandler?(.dataLoaded)
                 case .failure(let error):
                     print(error)
                    self.eventhandler?(.error(error))
                     
                 }
         })
       /* ApiManager.shared.fetchProducts(completion: { response in
            self.eventhandler?(.stopLoading)
                switch response {
                case .success(let products):
                    print("Products",products)
                   self.products = products
                   self.eventhandler?(.dataLoaded)
                case .failure(let error):
                    print(error)
                   self.eventhandler?(.error(error))
                    
                }
        })*/
    }
}
extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
