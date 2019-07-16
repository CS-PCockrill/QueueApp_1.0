//
//  DetailViewController.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/19/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class DetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var item: Item? {
        didSet {
            navigationItem.title = item?.itemTitle
        }
    }
    
    let itemDetailsView: UIView = {
        let idv = UIView()
        idv.backgroundColor = UIColor.black
        idv.translatesAutoresizingMaskIntoConstraints = false
        return idv
    }()
    
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(ItemHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(ItemDescriptionCell.self, forCellWithReuseIdentifier: cellId)
//        itemDetailsView.anchor(top: view.topAnchor, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ItemHeader
        header.item = item
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemDescriptionCell
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
}

class ItemHeader: UICollectionViewCell {
    
    var item: Item? {
        didSet {
            if let imageName = item?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let favoritesIcon: UIButton = {
        let fi = UIButton(type: .system)
        fi.backgroundColor = .cyan
        fi.setImage(UIImage(named: "like_unselected")?.withRenderingMode(.alwaysTemplate), for: .normal)
        fi.tintColor = UIColor.black
        fi.contentMode = .scaleAspectFit
        return fi
    }()
    
    func setupViews() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(favoritesIcon)
        favoritesIcon.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 33, height: 33)
    }
}
