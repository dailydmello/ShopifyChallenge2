//
//  CustomCollectionsTableVC.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-10.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import UIKit

protocol CustomCollectionDelegate{
    func passCollection () -> JSONCustomCollection
}
class CustomCollectionsTableVC: UITableViewController{
    
    var collectionSelected: JSONCustomCollection?
    var customCollections = [JSONCustomCollection](){
        didSet{
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage =  UIImage(named: "shopify")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFit
        self.tableView.separatorColor = UIColor.black
        APIClient.fetchCustomCollection{result in
            if let result = result {
                self.customCollections = result
            }else{
                print("fetch data empty")
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier{
        case "displayDetail":
            if let collectionDetailVC = segue.destination as? CollectionDetailVC{
                collectionDetailVC.delegate = self}
        default:
            print("Unexpected segue identifier")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customCollections.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCollectionTableViewCell", for: indexPath) as! CustomCollectionTableViewCell
        
        let customCollection = customCollections[indexPath.row]
        cell.customCollectionTitle.text = customCollection.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collectionSelected = customCollections[indexPath.row]
    }
    
}

extension CustomCollectionsTableVC: CustomCollectionDelegate{
    
    func passCollection() -> JSONCustomCollection{
        guard let collectionSelected = collectionSelected else{
            fatalError("custom collection is nil")
        }
        return collectionSelected

    }
}


