//
//  CustomCollectionsTableVC.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-10.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import UIKit

protocol CustomCollectionTVCDelegate{
    func passData () -> [String]
}
class CustomCollectionsTableVC: UITableViewController, CustomCollectionTVCDelegate{
    
    var customCollections = [JSONCustomCollection](){
        didSet{
            tableView.reloadData()
        }
    }
    
    var collectionSelected: JSONCustomCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.fetchCustomCollection{result in
            if let result = result {
                self.customCollections = result
              //  print(result)
            }else{
                print("fetch data empty")
            }
        }
//        APIClient.fetchProducts(collectionId: "68424466488", completion: {result in
//            print(result as Any)
//        })
    }
    
    func passData() -> [String]{
        var tempArr = [String]()

        if let collectionSelected = collectionSelected{
            tempArr.append(String(collectionSelected.collectionId ?? 0))
            tempArr.append(collectionSelected.title ?? "")
            tempArr.append(collectionSelected.bodyHtml ?? "")
            tempArr.append(collectionSelected.collectionImageUrl ?? "")
            return tempArr
        }else{
            return ["nil"]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier{
        case "displayDetail":
            print("This is\(segue.destination)")

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


