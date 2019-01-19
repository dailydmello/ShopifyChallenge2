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
        let apiToContact = Constants.CustomCollection.apiUrl
        Alamofire.request(apiToContact).validate().responseJSON {response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let jsonCollections = json["custom_collections"].array
                if let jsonCollections = jsonCollections{
                    let collections = jsonCollections.compactMap{
                    JSONCustomCollection.init(json: $0)
                    }
                    completion(collections)
                } else{
                    completion(nil)
                     print("collections could not be parsed")
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    static func fetchProducts(with collectionId: Int, completion: @escaping FetchProductsCallback){
        let colletcionIdString = String(collectionId)
        let apiToContact = Constants.generateProductUrl(with: colletcionIdString)
        
        Alamofire.request(apiToContact).validate().responseJSON {response in
            
            switch response.result {
                case .success(let value):
                let json = JSON(value)
                let jsonCollects = json["collects"].array
                
                if let jsonCollects = jsonCollects{
                    //generates a product ID string "22535,235235,23553"
                    let productIdList = jsonCollects.map({$0["product_id"].stringValue}).joined(separator: ",")

                    let apiToContact = Constants.generateProductDetailUrl(with: productIdList)
                    Alamofire.request(apiToContact).validate().responseJSON {response in
                        switch response.result {
                            case .success(let value):
                            let json = JSON(value)
                            let jsonProducts = json["products"].array
                            if let jsonProducts = jsonProducts{
                              let products = jsonProducts.compactMap{JSONProuduct.init(json: $0)}
                                completion(products)
                            } else{
                                completion(nil)
                                print("jsonProducts is nil")
                            }
                        case .failure(let error):
                            print(error)
                            completion(nil)
                        }
                    }
                }else{
                    completion(nil)
                    print("jsonCollects is nil")
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
        
    }
}
