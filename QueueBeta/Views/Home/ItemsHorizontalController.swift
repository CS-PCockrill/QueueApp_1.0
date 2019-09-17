//
//  ItemsHorizontalController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/14/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import SDWebImage

class ItemsHorizontalController: BaseListController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    
    var appGroup: AppGroup?
    
    // Initialize it to null initially
    var didSelectHandler: ((FeedResults) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    var startingFrame: CGRect?
    //FIXME: Insert code when we have python API's
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.row] {
            didSelectHandler?(app)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        // Retrieve the feed results index path of each app dictionary data...
        let app = appGroup?.feed.results[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 190)
    }
}

class ItemCell: UICollectionViewCell {
    
    // create an instance of Item?
    // didSet images/text/etc..
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let businessName: UILabel = {
        let bn = UILabel()
        bn.font = UIFont.boldSystemFont(ofSize: 17)
        bn.textColor = UIColor.white
        bn.layer.masksToBounds = true
        bn.textAlignment = .center
        return bn
    }()
    
    let storeView: UIView = {
        let sv = UIView()
        sv.backgroundColor = .black
        sv.layer.opacity = 0.65
        sv.layer.masksToBounds = true
        sv.layer.cornerRadius = 7.5
        return sv
    }()
    
    let imageView = UIImageView(cornerRadius: 8)
    
    func setupViews() {
        addSubview(imageView)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
}
