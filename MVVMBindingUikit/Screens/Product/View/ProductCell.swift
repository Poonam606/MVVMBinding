//
//  ProductCell.swift
//  MVVMBindingUikit
//
//  Created by poonam on 01/05/25.
//

import UIKit
import SDWebImage
class ProductCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    
    @IBOutlet weak var btnPricing: UIButton!
    @IBOutlet weak var productprice: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productBackgroundView: UIView!
    var product: ProductModel? {
        didSet {
            productDetailConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func productDetailConfiguration(){
        guard let product = product else {
            return
        }
        labelTitle.text = product.title
        productDescription.text = product.description
        lblCategory.text = product.category
        productprice.text = "$\(product.price)"
        btnPricing.setTitle("\(product.rating.rate)", for: .normal)
        imageProduct.sd_setImage(with: URL(string: product.image))
    }

}
