//
//  NavSearchHeader.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/18/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import Foundation
import UIKit

class NavSearchHeader: UIView, UICollectionViewDelegate, UISearchBarDelegate {
    let cornerRadius: CGFloat = 3.0
    let containerView = UIView()
    
    let searchField: UISearchBar = {
        let search = UISearchBar()
        search.sizeToFit()
        search.placeholder = "Search"
        search.tintColor = .white
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.init(name: "Helvetica Neau", size: 24)
        search.autocapitalizationType = .none
        return search
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        layoutView()
    }
    
    func layoutView() {
        
        // set the shadow of the view's layer
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 3
        
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
//        containerView.layer.backgroundColor = UIColor.purple.cgColor
        searchField.delegate = self
        searchField.keyboardAppearance = .default
        searchField.insetsLayoutMarginsFromSafeArea = false
//        addSubview(containerView)
        
        //
        // add additional views to the containerView here
        //
        // add constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        // pin the containerView to the edges to the view
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        containerView.addSubview(searchField)
        searchField.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
