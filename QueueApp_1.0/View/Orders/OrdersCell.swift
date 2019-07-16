//
//  OrdersCell.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/20/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class OrdersCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupViews()
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    func setupViews() {
        let itemImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(named: "iPhone")
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = .red
//            iv.layer.cornerRadius = 15
            iv.layer.masksToBounds = true
            return iv
        }()
        let itemLabel: UILabel = {
            let il = UILabel()
            il.text = "Gold iPhone XR"
            il.font = UIFont.systemFont(ofSize: 20)
            return il
        }()
        let priceLabel: UILabel = {
            let pl = UILabel()
            pl.textAlignment = .center
            pl.text = "$598"
            pl.font = UIFont.boldSystemFont(ofSize: 20)
            return pl
        }()
        
        let contentView = UIView()
        contentView.layer.borderColor = UIColor.rgb(red: 236, green: 236, blue: 239).cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        addSubview(contentView)
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        contentView.addSubview(itemLabel)
        contentView.addSubview(itemImageView)
        contentView.addSubview(priceLabel)
        itemImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 125, height: 0)
//        self.roundCorners(view: itemImageView, corners: [.bottomLeft, .topLeft], radius: 15)
        itemLabel.anchor(top: topAnchor, left: itemImageView.rightAnchor, bottom: nil, right: priceLabel.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        priceLabel.anchor(top: topAnchor, left: itemLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 19, width: 0, height: 30)
    }
}
