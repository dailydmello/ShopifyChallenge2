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
    let collectionId: Int?
    let bodyHtml: String?
    let collectionImageUrl: String?
    
    init?(json: JSON) {
        guard
        let title = json["title"].string,
        let bodyHtml = json["body_html"].string,
        let collectionImageUrl = json["image"]["src"].string,
        let collectionId = json["id"].int else{
            return nil
        }
        self.title = title
        self.bodyHtml = bodyHtml
        self.collectionImageUrl = collectionImageUrl
        self.collectionId = collectionId
    }
}
