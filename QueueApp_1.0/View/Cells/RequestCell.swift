//
//  File.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/20/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class RequestCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let requestIcon: UIImageView = {
            let ri = UIImageView()
            ri.image = UIImage(named: "home_selected")
            ri.contentMode = .scaleAspectFit
            return ri
        }()
        
        addSubview(requestIcon)
        requestIcon.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
    }
}
