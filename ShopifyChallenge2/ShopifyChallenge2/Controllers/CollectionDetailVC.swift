//
//  CollectionDetailVC.swift
//  ShopifyChallenge2
//
//  Created by Ethan D'Mello on 2019-01-11.
//  Copyright © 2019 Ethan D'Mello. All rights reserved.
//

import Foundation
import UIKit

class CollectionDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collectionTitleLabel: UILabel!
    
    @IBOutlet weak var collectionDescription: UILabel!
    
    @IBOutlet weak var collectionImageVIew: UIImageView!
    
    @IBOutlet weak var productsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
