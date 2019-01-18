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
    
    @IBOutlet weak var topContainer: UIView!
    
    var loadingView = UIView()
    var collection: JSONCustomCollection?
    var delegate: CustomCollectionDelegate?
    var collectionId: String = ""
    var collectionImageUrl: String?{
        get{
            
            return collection?.imageUrl
        }
        set{
            guard let newValue = newValue else{
                print("collectionURL is nil")
                return
            }
            
            if let contentUrl = URL(string: newValue) {
                do{
                let data = try Data(contentsOf: contentUrl)
                    collectionImageVIew.image = UIImage(data: data)
                }
                catch{
                    print("Error accessing contents of URL with error: \(error)")
                }
            }else{print("to table view cell url is nil")}
            
        }
    }
    var products = [JSONProuduct](){
        didSet{
           productsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topContainer.layer.borderColor = UIColor.black.cgColor
        topContainer.layer.borderWidth = 0.5
        let backgroundImage =  UIImage(named: "shopify")
        let imageView = UIImageView(image: backgroundImage)
        productsTableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFit
        productsTableView.separatorColor = UIColor.black
        productsTableView.rowHeight = 100
        displayLoadingScreen()
        
        if let delegate = delegate{
            collection = delegate.passCollection()
            collectionTitleLabel.text = collection?.title
            collectionDescription.text = collection?.bodyHtml
            collectionImageUrl = collection?.imageUrl

            
            if let collectionId = collection?.id{
                APIClient.fetchProducts(with: collectionId){result in
                    if let result = result{
                        self.products = result
                        self.loadingView.removeFromSuperview()
                        //print(self.products)
                    }else{
                        print("result is nil")
                    }
                }
            }else{
                fatalError("collection Id is empty")
            }
            
        }else{
            print("delegate is not set")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "productsTableViewCell", for: indexPath) as! CollectionDetailTableViewCell
        
        let product = products[indexPath.row]
        cell.inventoryLabel.text = "Inventory: \(String(product.inventory ?? 0))"
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
    
    func displayLoadingScreen(){
        //TODO: Redo UI contraints
//        foodCardBackground.center.x = self.view.center.x
        loadingView = UIView(frame: CGRect(x: 0, y: 0, width: productsTableView.frame.width*0.4, height: productsTableView.frame.height*0.4))
        loadingView.center = productsTableView.center
        loadingView.backgroundColor = UIColor.white
        loadingView.layer.borderColor = UIColor.black.cgColor
        loadingView.layer.borderWidth = 1.5
        loadingView.clipsToBounds = false
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center.x = loadingView.frame.width/2
        activityIndicator.center.y = loadingView.frame.height * 0.25
        activityIndicator.color = UIColor.black
        
        let loadingLabel = UILabel(frame: CGRect(x:0, y: loadingView.frame.height * 0.50, width: loadingView.frame.width, height: 30))
        loadingLabel.backgroundColor = UIColor.clear
        loadingLabel.textColor = UIColor.black
        loadingLabel.adjustsFontSizeToFitWidth = true
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading Collection!"
        loadingLabel.font = UIFont(name: "System", size: 18)
        
        loadingView.addSubview(activityIndicator)
        loadingView.addSubview(loadingLabel)
        
        self.view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
}
