//
//  DetailCategoryController.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/19/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class DetailCategoryController: UICollectionViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {

    var category: Item? {
        didSet{
        }
    }

    private let headerId = "headerId"
    private let cellId = "cellId"
    var categoryNames: [ItemCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.register(SearchHeader.self, forCellWithReuseIdentifier: "headerId")
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        setupSearchBar()

        collectionView?.register(SearchHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)

        collectionView.register(DetailItemCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SearchHeader
        
        header.item = category
        return header
    }
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
        let searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationItem.titleView = searchBarContainer
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailItemCell
        
        if indexPath.item % 2 == 0 {
            cell.photoImageView.image = UIImage(named: "phonesGroup")
        } else {
            cell.photoImageView.image = UIImage(named: "iPhone")
        }
        cell.titleLabel.text = "Group of Phones"

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Touch began")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 16 - 8) / 2
        let height = width + 10
        
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
}


class SearchBarContainerView: UIView, UISearchBarDelegate {

        var searchBar: UISearchBar
        
//        var onTextChange: ((IDTMSearchBar) -> Void)?
    
        init(customSearchBar: UISearchBar) {
            searchBar = customSearchBar
            super.init(frame: CGRect.zero)
            
            searchBar.delegate = self
            searchBar.placeholder = "Search"
            searchBar.barTintColor = UIColor.white
            searchBar.searchBarStyle = .minimal
            searchBar.returnKeyType = .done
            addSubview(searchBar)
        }
    override convenience init(frame: CGRect) {
            self.init(customSearchBar: UISearchBar())
            self.frame = frame
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    override func layoutSubviews() {
            super.layoutSubviews()
            searchBar.frame = bounds
        }
}

