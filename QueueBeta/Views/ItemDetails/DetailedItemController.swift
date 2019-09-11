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
    let offerId = "offerId"
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .rgb(red: 237, green: 236, blue: 236)
        self.navigationController?.navigationBar.tintColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        UIApplication.shared.statusBarView?.isHidden = false
//        UIApplication.shared.statusBarView?.backgroundColor = .white
        UIApplication.shared.statusBarView?.tintColor = .white
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.collectionView.contentInsetAdjustmentBehavior = .never

        collectionView.isScrollEnabled = true

        self.navigationController?.isToolbarHidden = false
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleMakeOffer))
        
        self.toolbarItems = [button]
        
        collectionView.register(ItemDetailsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(SellerInformationCell.self, forCellWithReuseIdentifier: sellerId)
        
        collectionView.register(ItemHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: photoId)
        collectionView.register(MakeOfferFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: offerId)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "x_close_button"), style: .plain, target: self, action: #selector(handleBack))
    }
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
////        return .lightContent
//    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150
        print(offset)
        
        if offset > 1 {
            offset = 1
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 0, saturation: offset, brightness: 0, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarView?.backgroundColor = color
        } else {
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 0.5, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarView?.backgroundColor = color
        }
    }
    
    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleMakeOffer() {
        let layout = UICollectionViewFlowLayout()
        let view = MakeOfferController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: view)
        UIApplication.shared.statusBarView?.isHidden = true
        self.present(navController, animated: true, completion: nil)
        
    }
    
    var headerView: ItemHeader?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: photoId, for: indexPath) as? ItemHeader
            
            headerView?.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            // TODO: Fix pixelated image quality
//            headerView?.imageView.layer.magnificationFilter = CALayerContentsFilter.linear
            return headerView!
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: offerId, for: indexPath) as? MakeOfferFooter
            
            return footer!
        }
        
        fatalError()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemDetailsCell
            
            cell.nameLabel.text = app?.trackName
            cell.descriptionLabel.text = app?.releaseNotes
            cell.priceLabel.text = app?.formattedPrice
            
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sellerId, for: indexPath) as! SellerInformationCell
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
            return cell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // calculate the necessary size for our cells
        if indexPath.item == 0 {
//            let dummyCell = ItemDetailsCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
//            dummyCell.nameLabel.text = app?.trackName
//            dummyCell.priceLabel.text = app?.formattedPrice
//            dummyCell.descriptionLabel.text = app?.releaseNotes
//            dummyCell.layoutIfNeeded()
            
//            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 400))
            
            return .init(width: view.frame.width, height: 240)
        } else {
            return .init(width: view.frame.width, height: 225)
        } 
        fatalError()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
}

class ItemHeader: UICollectionReusableView {
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "toyota2019"))
        view.contentMode = .scaleAspectFill
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code for layout
        self.backgroundColor = .red
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
