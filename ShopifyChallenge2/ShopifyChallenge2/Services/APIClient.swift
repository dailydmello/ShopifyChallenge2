//
//  APIClient.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-10.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias FetchCollectionCallback = ([JSONCustomCollection]?) -> Void
typealias FetchProductsCallback = ([JSONProuduct]?) -> Void

struct APIClient{
    
    static func fetchCustomCollection(completion:@escaping FetchCollectionCallback){
        let apiToContact = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        Alamofire.request(apiToContact).validate().responseJSON {response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let jsonCollections = json["custom_collections"].array
                if let jsonCollections = jsonCollections{
                    let collections = jsonCollections.compactMap({
                    JSONCustomCollection.init(json: $0)
                    })
                    completion(collections)
                } else{
                    completion(nil)
                     print("collections could not be parsed")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func fetchProducts(collectionId: String, completion: @escaping FetchProductsCallback){
        let apiToContact = "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\(collectionId)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        Alamofire.request(apiToContact).validate().responseJSON {response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let jsonCollects = json["collects"].array
                if let jsonCollects = jsonCollects{
                    let productIdList = jsonCollects.map({$0["product_id"].stringValue}).joined(separator: ",")
                    print(productIdList)
                    let apiToContact = "https://shopicruit.myshopify.com/admin/products.json?ids=\(productIdList)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
                    
                    Alamofire.request(apiToContact).validate().responseJSON {response in
                        switch response.result {
                            
                        case .success(let value):
                            let json = JSON(value)
                            let jsonProducts = json["products"].array
                            if let jsonProducts = jsonProducts{
                              let products = jsonProducts.compactMap({JSONProuduct.init(json: $0)})
                                completion(products)
                            } else{
                                //completion(nil)
                                print("collections could not be parsed")
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                    
                } else{
                    //completion(nil)
                    print("collections could not be parsed")
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
