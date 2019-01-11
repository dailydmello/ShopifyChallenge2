//
//  JSONCustomCollection.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-10.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import Foundation
import SwiftyJSON

struct JSONCustomCollection{
    
    let title: String?
    let collectionId: String?
    
    init?(json: JSON) {
        guard
        let title = json["title"].string,
        let collectionId = json["id"].string else{
            return nil
        }
        self.title = title
        self.collectionId = collectionId
    }
}
