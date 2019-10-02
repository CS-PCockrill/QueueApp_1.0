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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        layoutView()
    }
    
    @objc func handleOpenSearch() {
        let view = UISearchController()
        let navController = UINavigationController(rootViewController: view)
        self.window?.rootViewController?.present(navController, animated: true, completion: nil)
    }
    
    func layoutView() {
        let openSearchGesture = UIGestureRecognizer(target: self, action: #selector(handleOpenSearch))
        openSearchGesture.isEnabled = true
        
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
//        searchBar.addGestureRecognizer(openSearchGesture)
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
//        searchBar.isUserInteractionEnabled = false
        searchBar.isTranslucent = false
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        // set the shadow of the view's layer
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowRadius = 3
        
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
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
        
        containerView.addSubview(searchBar)
        searchBar.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
