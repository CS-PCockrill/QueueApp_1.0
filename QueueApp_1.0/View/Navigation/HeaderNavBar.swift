//
//  HeaderNavBar.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/13/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

// Do we want to change this to a CollectionView Header or keep it as is??

class HeaderNavBar: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    let cellId = "cellId"
    let vc = NavCell()
    var itemCategory: [ItemCategory]?
//    var Category: CategoryCell?
    var Nav: NavCell?
    
    let requestIcon: UIImageView = {
        let ri = UIImageView(image: UIImage(named: "search_unselected"))
        ri.backgroundColor = .orange
        return ri
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = itemCategory?.count {
            return count
        } else { return 0 }
    }
    
//    var category: UILabel
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NavCell
//            cell.categoryTitle.text = nil
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NavCell
            if let categories = itemCategory {
                    cell.categoryTitle.text = " Category "
//                    print(item)
            }
            return cell
        }
        
//        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.item == 0) {
            print("Custom Request")
        } else {
            let layout = UICollectionViewFlowLayout()
            let categoryViewController = DetailCategoryController(collectionViewLayout: layout)
            // Set title of navigationItem in Detail Category...
            if let name = itemCategory {
                // Global 'category' variable...
                // FIXME: If needed
                category = name[indexPath.item].name
                if name[indexPath.item].name == "Furniture" {
                    categoryViewController.collectionView.backgroundColor = .green
//                    categoryViewController.searchHeader.categoryName.text = "Test"
                }
            }
            // Push the controller onto the Detail Controller
            (superview?.next as? UIViewController)?.navigationController?.pushViewController(categoryViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Will need to return a dynamic size for the space of text taken up in each cell.
        let height = collectionView.frame.height
        if indexPath.item != 0 {
            
            return CGSize(width: 120, height: height)
        } else {

            return CGSize(width: vc.categoryTitle.intrinsicContentSize.width + 20, height: height)
        }
        
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.rgb(red: 236, green: 236, blue: 239)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let dividerView: UIView = {
        let dv = UIView()
        dv.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        dv.translatesAutoresizingMaskIntoConstraints = false
        return dv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        itemCategory = ItemCategory.sampleItemCategories()

        addSubview(collectionView)
        collectionView.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
        
//        collectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        collectionView.register(NavCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0)
    }

}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
