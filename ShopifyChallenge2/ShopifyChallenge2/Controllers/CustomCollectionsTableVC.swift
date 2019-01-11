//
//  CustomCollectionsTableVC.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-10.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import UIKit

class CustomCollectionsTableVC: UITableViewController {
    
    var customCollections = [JSONCustomCollection](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        APIClient.fetchCustomCollection{result in
//            if let result = result {
//                self.customCollections = result
//                //self.tableView.reloadData()
//            }else{
//                print("fetch data empty")
//            }
//        }
        APIClient.fetchProducts(collectionId: "68424466488", completion: {result in
            print(result)
        })
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
    
    
}


