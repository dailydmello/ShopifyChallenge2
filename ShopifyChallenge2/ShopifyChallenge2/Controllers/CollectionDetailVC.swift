//
//  CollectionDetailVC.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-11.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import Foundation
import UIKit

class CollectionDetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var collectionTitleLabel: UILabel!
    @IBOutlet weak var collectionDescription: UILabel!
    @IBOutlet weak var collectionImageVIew: UIImageView!
    @IBOutlet weak var productsTableView: UITableView!
    
    //var collectionTitle : String?
    //var collectionDescription: String?
    var collectionImageUrl: String?
    var collectionId: String = ""
    var data = [String]()
    var products = [JSONProuduct](){
        didSet{
           productsTableView.reloadData()
        }
    }
    
    
    var delegate: CustomCollectionTVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let delegate = delegate{
            data = delegate.passData()
            print(data)
            collectionId = data[0]
            collectionTitleLabel.text = data[1]
            collectionDescription.text = data[2]
            

            
            if let contentUrl = URL(string: data[3]) {
                let data = try? Data(contentsOf: contentUrl)
                collectionImageVIew.image = UIImage(data: data!)
            }else{print("unable to table view cell pic")
            }
            
            APIClient.fetchProducts(collectionId: collectionId, completion: {result in
                if let result = result{
                    self.products = result
                     print(self.products)
                }else{
                    print("result failed")
                }
            })
            
        }else{
            print("delegate pass data failed")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "productsTableViewCell", for: indexPath) as! CollectionDetailTableViewCell
        
        let product = products[indexPath.row]
        cell.inventoryLabel.text = String(product.inventory ?? 0)
        cell.productTitleLabel.text = product.productTitle
        
        if let url = product.productImageUrl, let contentUrl = URL(string: url) {
            //so data doesnt block UI on main queue
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: contentUrl)
                DispatchQueue.main.async {
                    cell.productImageView.image = UIImage(data: data!)
                }
            }
        }else{print("unable to table view cell pic")
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
}
