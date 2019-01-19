//
//  Constants.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-18.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import Foundation

struct Constants {
    
    static let customCollectionTableViewCell = "customCollectionTableViewCell"
    static let productsTableViewCell = "productsTableViewCell"
    static let inventoryString = "Inventory:"
    static let loadingCollectionString = "Loading Collection!"
    static let displayDetail = "displayDetail"
    
    struct ImageName{
        static let shopify = "shopify"
    }
    
    struct CustomCollection{
        static let apiUrl = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    }
    
    static func generateProductUrl(with colletcionId: String) -> String{
        let urlString = "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\(colletcionId)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        return urlString
    }
    
    static func generateProductDetailUrl(with productIdList: String) -> String{
        let urlString = "https://shopicruit.myshopify.com/admin/products.json?ids=\(productIdList)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        return urlString
    }
}
