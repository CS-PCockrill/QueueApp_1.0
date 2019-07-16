//
//  ViewController.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/13/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import Firebase

// Look into doing a drop shadow type frame on the edges of the screen on the side of the screen...

// Category Name on DetailCategoryController...
var category: String?

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    let cellId = "cellId"
    let categoryId = "categoryId"

    var featuredItems: FeaturedItems?
    var searchHeader: SearchHeader?
    let currentAddress = "12619 winter wren court"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(CompactCategoryCell.self, forCellWithReuseIdentifier: categoryId)
//        setupHeaderBar()
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let addressButton: UIButton = {
            let ab = UIButton(type: .system)
            ab.setTitle(currentAddress, for: .normal)
            ab.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            ab.addTarget(self, action: #selector(handleAddresses), for: .touchUpInside)
            return ab
        }()
        let address = UIBarButtonItem(customView: addressButton)
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = address
        
        let searchImage = UIImage(named: "search_selected")
        let search = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchTapped))
        search.tintColor = .black
        self.navigationItem.rightBarButtonItem = search
        collectionView?.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    let addressLauncher = AddressLauncher()
    
    @objc func handleAddresses() {
        addressLauncher.showAddresses()
    }
    
    @objc func searchTapped() {
        let layout = UICollectionViewFlowLayout()
        let searchController = SearchViewController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: searchController)
        present(navController, animated: true, completion: nil)
    }
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let categoryViewController = DetailCategoryController(collectionViewLayout: layout)
            // Set title of navigationItem in Detail Category...
        navigationController?.pushViewController(categoryViewController, animated: true)

    }
    
    func showCategoryDetails(category: Item) {
        let layout = UICollectionViewFlowLayout()
        let categoryDetailController = DetailCategoryController(collectionViewLayout: layout)
        categoryDetailController.category = category
//        categoryDetailController.categoryNames = category
        navigationController?.pushViewController(categoryDetailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = featuredItems?.itemCategories?.count {
            return count
        } else { 
            return 5
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as! CompactCategoryCell
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
            cell.featuredCategoriesController = self
            cell.itemCategory = featuredItems?.itemCategories?[indexPath.item]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 40
        height += LONG_HEIGHT
        if (indexPath.item == 0) {
            return CGSize(width: view.frame.width, height: 175)
        }
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func showItemDetails(item: Item) {
        let layout = UICollectionViewFlowLayout()
        let categoryDetailController = DetailViewController(collectionViewLayout: layout)
        
        categoryDetailController.item = item
        navigationController?.pushViewController(categoryDetailController, animated: true)
    }
}

