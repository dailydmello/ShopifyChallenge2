//
//  CollectionDetailTableViewCell.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-11.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import Foundation
import UIKit

class CollectionDetailTableViewCell: UITableViewCell{
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var inventoryLabel: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        self.isUserInteractionEnabled = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }
}
