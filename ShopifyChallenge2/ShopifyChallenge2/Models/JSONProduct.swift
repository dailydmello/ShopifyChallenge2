//
//  JSONProduct.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-10.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import Foundation
import SwiftyJSON

struct JSONProuduct{
    
    let productTitle: String?
    let inventory: Int?
    let productImageUrl: String?
    
    init?(json:JSON) {
        guard
        let productTitle = json["title"].string,
        let productImageUrl = json["image"]["src"].string,
        let variants = json["variants"].array
        else{
            return nil
        }
        self.productTitle = productTitle
        self.productImageUrl = productImageUrl
        self.inventory = variants.reduce(0){sum, json in
            sum + json["inventory_quantity"].int!
        }
    }
}
