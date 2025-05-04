//
//  ProductViewController.swift
//  MVVMBindingUikit
//
//  Created by poonam on 31/03/25.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var productTable: UITableView!
private var viewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configuration()
        // Do any additional setup after loading the view.
    }
    

 

}
extension ProductViewController {
    func configuration(){
        productTable.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        obserEvent()
    }
    func initViewModel(){
        viewModel.fetchProduct()
    }
    func obserEvent(){
        viewModel.eventhandler = { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .loading :
                print("Loading")
            case .stopLoading:
                print("stopLoading")
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.productTable.delegate =  self
                    self.productTable.reloadData()
                    print(self.viewModel.products)
                }
                
            case .error(let error):
                print("error",error)
            }
            
        }
    }
}
extension ProductViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTable.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
    
}
