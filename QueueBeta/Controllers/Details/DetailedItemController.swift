//
//  DetailedItemController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import PullToDismiss
import Photos

class DetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // Item Details ID
    let cellId = "cellId"
    // Seller Details ID
    let sellerId = "sellerId"
    
    let detailsId = "detailsId"
    // Photos header ID
    let photoId = "headerId"
    // Offer button ID
    
    // FIXME: Code to make variables in detailView show current item details
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    var statusBarView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .rgb(red: 237, green: 236, blue: 236)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = false
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        
        collectionView.register(ItemHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: photoId)
        collectionView.register(ItemOverviewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(SellerInformationCell.self, forCellWithReuseIdentifier: sellerId)
        collectionView.register(MoreItemDetail.self, forCellWithReuseIdentifier: detailsId)
        
        
        let app = UIApplication.shared
        let statusBarHeight: CGFloat = app.statusBarFrame.size.height
        
        statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: statusBarHeight))
//        statusBarView.backgroundColor = .systemBlue
        view.addSubview(statusBarView)
//        let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//        UIApplication.shared.statusBarView?.isHidden = false
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.collectionView.contentInsetAdjustmentBehavior = .never

        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleMakeOffer))
        
        self.toolbarItems = [button]

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "x_close_button"), style: .plain, target: self, action: #selector(handleBack))
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150

        if offset > 1 {
            offset = 1
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationController?.navigationBar.tintColor = UIColor(white: 0, alpha: offset)
            self.navigationController?.navigationBar.backgroundColor = color
//            UIApplication.shared.statusBarView?.backgroundColor = color
            if #available(iOS 13.0, *) {
                statusBarView.backgroundColor = color
            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = color
            }
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(white: 0, alpha: offset)]
            self.title = app?.trackName
        } else {
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationController?.navigationBar.tintColor = UIColor(white: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
//            UIApplication.shared.statusBarView?.backgroundColor = color
            if #available(iOS 13.0, *) {
                statusBarView.backgroundColor = color
            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = color
            }
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(white: 0, alpha: offset)]
            self.title = app?.trackName

        }
    }
    
    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleMakeOffer() {
        let layout = UICollectionViewFlowLayout()
        let view = MakeOfferController(collectionViewLayout: layout)
        view.app = app
        let navController = UINavigationController(rootViewController: view)
        navController.modalPresentationStyle = .popover
//        UIApplication.shared.statusBarView?.isHidden = true
        self.present(navController, animated: true, completion: nil)
        
    }
    
    var headerView: ItemHeader?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: photoId, for: indexPath) as? ItemHeader
            headerView?.app = self.app
            headerView?.collectionView.reloadData()
//            let image = app?.artworkUrl100
//            headerView?.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            // TODO: Fix pixelated image quality
            
            return headerView!
        }
        
        fatalError()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemOverviewCell
            
            cell.nameLabel.text = app?.trackName
            cell.descriptionLabel.text = app?.releaseNotes
            cell.priceLabel.text = app?.formattedPrice
            
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailsId, for: indexPath) as! MoreItemDetail
            cell.descriptionLabel.text = app?.releaseNotes
            
            
            return cell
            
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sellerId, for: indexPath) as! SellerInformationCell
            
            return cell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // calculate the necessary size for our cells
        if indexPath.item == 0 {
            let dummyCell = ItemOverviewCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.nameLabel.text = app?.trackName
            dummyCell.priceLabel.text = app?.formattedPrice
//            dummyCell.descriptionLabel.text = app?.releaseNotes
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 400))
            return .init(width: view.frame.width, height: estimatedSize.height)
            
        } else if indexPath.item == 1 {
            let dummyCell = MoreItemDetail(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
//            dummyCell.titleLabel.text = "Item Details"
            dummyCell.descriptionLabel.text = app?.releaseNotes
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 400))
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else  if indexPath.item == 2 {
            return .init(width: view.frame.width, height: 247)
        } 
        fatalError()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
}

class ItemHeader: UICollectionReusableView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let cellId = "cellId"

    var app: Result?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoCell
        cell.imageView.sd_setImage(with: URL(string: app?.screenshotUrls[indexPath.item] ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.lightGray
        cv.isPagingEnabled = true
        cv.layer.masksToBounds = true
        cv.isScrollEnabled = true
        cv.alwaysBounceVertical = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code for layout
//        addSubview(imageView)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView.addSubview(imageView)
//        imageView.fillSuperview()
        
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    var animator: UIViewPropertyAnimator!
    
    fileprivate func setupVisualEffectBlur() {
        // Treat this as the end state of our animation
        

//        animator.fractionComplete = 0.5
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PhotoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private func layoutViews() {
        addSubview(imageView)
        imageView.fillSuperview()
    }
}

extension UIImage {
    func resizeUI(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
