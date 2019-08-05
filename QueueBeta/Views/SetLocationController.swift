//
//  SetLocationController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import MapKit
import UIKit

class SetLocationController: UIViewController, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    let step: Float = 1
    
    let headerId = "headerId"
    var mapView: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applyGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBack))
        applyGesture.numberOfTapsRequired = 1
        
        self.title = "Change location"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.barTintColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        navigationController?.toolbar.isTranslucent = false
        view.backgroundColor = UIColor.white
        
        let searchBar = UISearchBar()
        let searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        
        view.addSubview(searchBarContainer)
        searchBarContainer.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height - 138
        
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 44, width: (displayWidth), height: displayHeight))
        self.view.addSubview(mapView!)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleBack))
        
        setupFooterView()
        self.navigationController?.toolbar.addGestureRecognizer(applyGesture)
        self.navigationController?.toolbar.addSubview(applyButton)
        applyButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 10, paddingBottom: 2, paddingRight: 10, width: (view.frame.width), height: 44)
        
        
        //        cancelButton.isUserInteractionEnabled = true
        //        cancelButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 10, paddingBottom: 2, paddingRight: 5, width: (view.frame.width - 15) / 2, height: 0)
        
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
    
    let distanceNum: UILabel = {
        let dn = UILabel()
        dn.font = UIFont.systemFont(ofSize: 17)
        dn.textColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        return dn
    }()
    
    func setupFooterView() {
        
        let distanceView = UIView()
        distanceView.backgroundColor = .white
        view.addSubview(distanceView)
        distanceView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        
        let distanceSlider = UISlider()
        distanceSlider.minimumValue = 0
        distanceSlider.maximumValue = 50
        distanceSlider.isContinuous = true
        distanceSlider.tintColor = UIColor.rgb(red: 1, green: 145, blue: 244)
        distanceSlider.addTarget(self, action: #selector(SetLocationController.sliderViewDidChange(_:)), for: .valueChanged)
        
        distanceView.addSubview(distanceSlider)
        distanceView.addSubview(distanceNum)
        distanceSlider.anchor(top: distanceView.topAnchor, left: distanceView.leftAnchor, bottom: distanceView.bottomAnchor, right: distanceNum.leftAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        distanceNum.anchor(top: distanceView.topAnchor, left: nil, bottom: nil, right: distanceView.rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 70, height: 20)
        //        distanceNum.centerYAnchor.constraint(equalTo: distanceView.centerYAnchor)
    }
    
    @objc func sliderViewDidChange(_ sender: UISlider!) {
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        distanceNum.text = "\(Int(roundedStepValue)) miles"
        
    }
}
