//
//  DeliveryInformationController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 9/11/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class DeliveryInformationController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        collectionView.backgroundColor = .purple
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.title = "Delivery Information"
    }
    
    @objc func handleShare() {
        print("Saving and sharing item to marketplace")
    }
    
    
    // Payout Information
    // Pick-up address
    // Available time frame?
    
    // Meetup or Delivery??
}
