//
//  HomeViewController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//
import UIKit

class HomeViewController: BaseListController, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UISearchBarDelegate {
    
    let cellId = "cellId"
    let headerId = "headerId"
    let categoryId = "categoryId"
    
//    var featuredItems: FeaturedItems?
    var searchHeader: SearchHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)

        collectionView?.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
        
        collectionView.register(CategoriesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        setupNavigationBar()
        fetchData()
    }
    
    var editorsChoiceGames: AppGroup?
    var groups = [AppGroup]()
    
    fileprivate func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        
        print("Fetching Data from API")
        dispatchGroup.enter()
        Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json") { (appGroup, error) in
            dispatchGroup.leave()
            group1 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing-ipad/all/25/explicit.json") { (appGroup, error) in
            dispatchGroup.leave()
            group2 = appGroup
            
        }
        
        dispatchGroup.enter()
        Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/25/explicit.json") { (appGroup, error) in
            dispatchGroup.leave()
            group2 = appGroup
            
        }
//            self.editorsChoiceGames = appGroup
            
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing(completion: { (appGroup, err) in
            dispatchGroup.leave()
            group3 = appGroup
        })
        
        dispatchGroup.notify(queue: .main) {
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    fileprivate let navSearchHeader: NavSearchHeader = {
        let search = NavSearchHeader()

        return search
    }()
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.addSubview(navSearchHeader)
        navigationController?.view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: navSearchHeader)
        navigationController?.view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: navSearchHeader)
//        navSearchHeader.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        view.addSubview(whiteView)
        whiteView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 10)
        
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
//        let layout = StretchHeaderLayout()
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
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        
        let appGroup = groups[indexPath.item]
        
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            
            let layout = UICollectionViewFlowLayout()
            let detailItemController = DetailViewController(collectionViewLayout: layout)
            detailItemController.appId = feedResult.id
//            detailItemController.toolbar.isHidden = true
            let navController = UINavigationController(rootViewController: detailItemController)
//            navController.hidesBottomBarWhenPushed = true
            navController.modalPresentationStyle = .overCurrentContext
            navController.toolbar.barStyle = .blackTranslucent;
            navController.navigationController?.title = "TEST"
            
            self?.present(navController, animated: true, completion: nil)
            
        }
//            cell.itemCategory = featuredItems?.itemCategories?[indexPath.item]
            
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
