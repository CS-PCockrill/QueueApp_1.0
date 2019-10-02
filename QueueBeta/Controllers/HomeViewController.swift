//
//  HomeViewController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//
import UIKit
import MapKit

class HomeViewController: BaseListController, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UISearchBarDelegate, CLLocationManagerDelegate {
    
    let cellId = "cellId"
    let headerId = "headerId"
    let categoryId = "categoryId"
    
//    var featuredItems: FeaturedItems?
    var searchHeader: SearchHeader?
    var detailCategoryController: DetailCategoryController?
    var homeLocationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 15, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
//        view.addGestureRecognizer(tap)
        
        collectionView.register(CategoriesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false

//        homeLocationManager = CLLocationManager()
//        homeLocationManager?.requestWhenInUseAuthorization()
        
        setupNavigationBar()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      navigationController?.navigationBar.barStyle = .black
    }
    
    
    
    var editorsChoiceGames: AppGroup?
    var groups = [AppGroup]()
    
    fileprivate func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        var group4: AppGroup?
        
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
        Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json") { (appGroup, error) in
            dispatchGroup.leave()
            group4 = appGroup
            
        }
        
        dispatchGroup.enter()
        Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/25/explicit.json") { (appGroup, error) in
            dispatchGroup.leave()
            group3 = appGroup
            
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
            if let group = group4 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CategoriesHeader
//        let appGroup = groups[indexPath.item].feed
//        header.itemCategoriesHorizontalController.appGr
//        header.itemCategoriesHorizontalController.appGroup = appGroup
//        header.itemCategoriesHorizontalController.collectionView.reloadData()
        
//        header.itemCategoriesHorizontalController.appGroup = appGroup
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }
    
    fileprivate let navSearchHeader: NavSearchHeader = {
        let search = NavSearchHeader()

        return search
    }()

    fileprivate func setupNavigationBar() {
        self.navigationController?.navigationBar.addSubview(navSearchHeader)
//        navSearchHeader.fillSuperview(padding: .init(top: 0, left: 8, bottom: 0, right: 8))
        navSearchHeader.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))

        let dividerView = UIView()
        dividerView.backgroundColor = UITableView().separatorColor
        
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        view.addSubview(whiteView)
        view.addSubview(dividerView)
        whiteView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: dividerView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 8)
        dividerView.anchor(top: whiteView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
//    override var prefersStatusBarHidden: Bool {
//      return true
//    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .default
        } else {
            return .default
        }
    }
    
//    let addressLauncher = AddressLauncher()

//    @objc func handleAddresses() {
//        addressLauncher.showAddresses()
//    }
    
    @objc func searchTapped() {
//        let layout = StretchHeaderLayout()
        let layout = UICollectionViewFlowLayout()
        let searchController = SearchViewController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: searchController)
        self.navigationController?.pushViewController(navController, animated: true)
    }
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        navController.modalPresentationStyle = .popover
        let layout = UICollectionViewFlowLayout()
        let appGroup = groups[indexPath.item]
        let detailCategoryController = DetailCategoryController(collectionViewLayout: layout)
        detailCategoryController.appGroup = appGroup
        detailCategoryController.collectionView.reloadData()
        
        let navController = UINavigationController(rootViewController: detailCategoryController)
        navController.modalPresentationStyle = .fullScreen

        self.present(navController, animated: true, completion: nil)
        
        // Tapping on category section title (i.e. Local Picks, Mobile Phones) Section TITLE
        // TODO: Select the detail category Controller.
        
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
            let navController = UINavigationController(rootViewController: detailItemController)
            navController.modalPresentationStyle = .overFullScreen
//            navController.modalTransitionStyle = .crossDissolve
            
            self?.navigationController?.present(navController, animated: true, completion: nil)
        }
//            cell.itemCategory = featuredItems?.itemCategories?[indexPath.item]
            
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: (view.frame.width / 2) - 16 + 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
}
