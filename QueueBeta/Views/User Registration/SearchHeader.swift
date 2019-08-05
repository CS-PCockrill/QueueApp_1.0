//
//  SearchHeader.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class SearchHeader: UICollectionViewCell {
    
    var categoryCell: CategoryCell?
    //    var delegate: CellDelegate?
    var item: Item? {
        didSet {
            categoryName.text = item?.categoryTitle
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryName: UILabel = {
        let cn = UILabel()
        cn.text = "Category Name"
        cn.font = UIFont.boldSystemFont(ofSize: 26)
        return cn
    }()
    
    let addressLabel: UILabel = {
        let al = UILabel()
        al.text = "Fairfax - 7 mi"
        al.font = UIFont.boldSystemFont(ofSize: 17)
        al.textColor = UIColor.black
        return al
    }()
    
    let filterLabel: UILabel = {
        let fl = UILabel()
        fl.text = "Filters"
        fl.textAlignment = .center
        fl.font = UIFont.boldSystemFont(ofSize: 17)
        fl.textColor = UIColor.black
        return fl
    }()
    let sortLabel: UILabel = {
        let sl = UILabel()
        sl.text = "Sort"
        sl.textAlignment = .center
        sl.font = UIFont.boldSystemFont(ofSize: 17)
        return sl
    }()
    
    func setupViews() {
        self.isUserInteractionEnabled = true
        
        // Category Button Name View
        addSubview(categoryName)
        let categoryGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCategories))
        categoryGesture.numberOfTapsRequired = 1
        categoryName.isUserInteractionEnabled = true
        categoryName.addGestureRecognizer(categoryGesture)
        categoryName.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        // Address Button View
        let addressView = UIView()
        let addressGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleAddress))
        addressView.backgroundColor = UIColor.rgb(red: 236, green: 236, blue: 239)
        addressView.layer.cornerRadius = 15
        addressView.layer.masksToBounds = true
        addressGesture.numberOfTapsRequired = 1
        addressView.addGestureRecognizer(addressGesture)
        addSubview(addressView)
        
        addressView.anchor(top: categoryName.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        addressView.addSubview(addressLabel)
        addressLabel.anchor(top: addressView.topAnchor, left: addressView.leftAnchor, bottom: addressView.bottomAnchor, right: addressView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        // Filter Button View
        let filterView = UIView()
        filterView.backgroundColor = UIColor.rgb(red: 236, green: 236, blue: 239)
        filterView.layer.cornerRadius = 15
        filterView.layer.masksToBounds = true
        let filterGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(filterTapped))
        filterGesture.numberOfTapsRequired = 1
        filterView.addGestureRecognizer(filterGesture)
        addSubview(filterView)
        
        filterView.anchor(top: categoryName.bottomAnchor, left: addressView.rightAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 70, height: 40)
        filterView.addSubview(filterLabel)
        filterLabel.anchor(top: filterView.topAnchor, left: filterView.leftAnchor, bottom: filterView.bottomAnchor, right: filterView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        // Sort Button View
        let sortView = UIView()
        sortView.backgroundColor = .rgb(red: 236, green: 236, blue: 239)
        sortView.layer.cornerRadius = 15
        sortView.layer.masksToBounds = true
        let sortGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sortTapped))
        sortGesture.numberOfTapsRequired = 1
        sortView.addGestureRecognizer(sortGesture)
        addSubview(sortView)
        
        sortView.anchor(top: categoryName.bottomAnchor, left: filterView.rightAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 60, height: 40)
        sortView.addSubview(sortLabel)
        sortLabel.anchor(top: sortView.topAnchor, left: sortView.leftAnchor, bottom: sortView.bottomAnchor, right: sortView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
    }
    
    @objc func handleCategories() {
        print("More Categories")
    }
    
    @objc func filterTapped() {
        print("Filter Button")
    }
    
    @objc func sortTapped() {
        print("Sort Button")
    }
    
    @objc func handleAddress() {
        //        delegate?.presentViewController()
        let navController = UINavigationController(rootViewController: SetLocationController())
        self.window?.rootViewController?.present(navController, animated: true, completion: nil)
        //        (superview?.next as? UIViewController)?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
}
