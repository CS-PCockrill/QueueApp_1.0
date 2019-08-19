//
//  SetLocationController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import MapKit
import UIKit

class SetLocationController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    let step: Float = 1
    
    let headerId = "headerId"
    let footerId = "footerId"
    let customRadius = "customRadius"
    let suggestedRadius = "suggestedRadius"
    var mapView: MKMapView?
    
    let search: NavSearchHeader = {
        let search = NavSearchHeader()

        return search
    }()
    
    func dismissView() {
        print("dismiss?")
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isScrollEnabled = false
        let applyGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBack))
        applyGesture.numberOfTapsRequired = 1
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        self.title = "Set location"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.isToolbarHidden = true
//        navigationController?.toolbar.barTintColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        navigationController?.toolbar.isTranslucent = true
        collectionView.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleBack))
        navigationController?.navigationBar.tintColor = .black
//        let searchBar = UISearchBar()
//        let searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
//        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        
        view.addSubview(search)
        search.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        collectionView.register(MapViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(ApplyLocationFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        collectionView.register(CustomRadiusCell.self, forCellWithReuseIdentifier: customRadius)
        collectionView.register(SuggestedRadiusCell.self, forCellWithReuseIdentifier: suggestedRadius)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! ApplyLocationFooter
            return footer
        } else if (kind == UICollectionView.elementKindSectionHeader) {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MapViewHeader
            
            return header
        }
        fatalError()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customRadius, for: indexPath) as! CustomRadiusCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: suggestedRadius, for: indexPath) as! SuggestedRadiusCell
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 75 - 8)
        } else {
            return CGSize(width: view.frame.width, height: 125)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height * 0.66) - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 58)
    }
    
    @objc func handleApply() {
        print("Applying")
    }
    
    @objc func handleBack() {
        print("Back")
        dismiss(animated: true, completion: nil)
    }
    
    let applyButton: UILabel = {
        let ab = UILabel()
        //        ab.setTitle("Apply", for: .normal)
        //        ab.setTitleColor(.white, for: .normal)
        ab.text = "Apply"
        ab.font = UIFont.boldSystemFont(ofSize: 20)
        ab.textColor = .white
        ab.textAlignment = .center
        ab.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        //        ab.addTarget(self, action: #selector(handleApply), for: .touchUpInside)
        //        ab.layer.cornerRadius = 7.5
        ab.layer.masksToBounds = true
        return ab
    }()
    
}
