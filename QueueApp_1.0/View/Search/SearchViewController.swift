//
//  SearchViewController.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/17/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    let cellId = "cellId"
    let categories = ["Local", "Recents", "Vehicles"]
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search Queue"
        sb.barTintColor = UIColor.gray
//        sb.layer.cornerRadius = 50
//        sb.layer.masksToBounds = true
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 236, green: 236, blue: 239)
        sb.delegate = self
        sb.autocapitalizationType = .none
        return sb
    }()
    
//    let sectionLabel: UILabel = {
//        let sl = UILabel()
//        sl.text = "Recents"
//        sl.font = UIFont.boldSystemFont(ofSize: 17)
//        return sl
//    }()
    
    let dividerLineView: UIView = {
        let dl = UIView()
        dl.backgroundColor = .gray
        return dl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.addSubview(searchBar)
        
//        let navBar = navigationController?.navigationBar
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        let searchBar = UISearchBar()
        let searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationItem.titleView = searchBarContainer
    
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.alwaysBounceVertical = true
    }
    
    @objc func handleCancel() {
        // Bug that causes the searchBar background color to become clear on next time you tap search
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Locating item...")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

