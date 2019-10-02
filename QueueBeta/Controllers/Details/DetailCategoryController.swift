//
//  DetailCategoryController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//


import UIKit

class DetailCategoryController: UICollectionViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    var didSelectHandler: ((FeedResults) -> ())?
    var appGroup: AppGroup?
    
    var appId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
                let app = result?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
        }
    }
    var app: Result?
    
    private let headerId = "headerId"
    private let cellId = "cellId"
//    var categoryNames: [ItemCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        collectionView.register(SearchHeader.self, forCellWithReuseIdentifier: "headerId")
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        
        collectionView?.register(SearchHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView.register(DetailItemCell.self, forCellWithReuseIdentifier: cellId)
        
//        navigationController?.navigationBar.barTintColor = .blue
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: (UIImage(named: "gear")), style: .plain, target: self, action: #selector(handleDismiss))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 92)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SearchHeader
        header.categoryName.text = appGroup?.feed.title
        
        return header
    }
    
//    func setupSearchBar() {
//        self.navigationController?.navigationBar.addSubview(navSearchBar)
//        navSearchBar.fillSuperview(padding: .init(top: 0, left: 50, bottom: 0, right: 0))
//
//        let whiteView = UIView()
//        whiteView.backgroundColor = .white
//        view.addSubview(whiteView)
//        whiteView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 10)
//    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailItemCell
        
        let app = appGroup?.feed.results[indexPath.item]
        cell.photoImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        cell.titleLabel.text = app?.name
        
        didSelectHandler = { [weak self] feedResult in
            
            let layout = UICollectionViewFlowLayout()
            let detailItemController = DetailViewController(collectionViewLayout: layout)
            detailItemController.appId = feedResult.id
            let navController = UINavigationController(rootViewController: detailItemController)
            navController.modalPresentationStyle = .overFullScreen
            
            self?.present(navController, animated: true, completion: nil)
        }
//        cell.priceLabel.text =
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.row] {
            didSelectHandler?(app)
        }
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
        return appGroup?.feed.results.count ?? 0
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
