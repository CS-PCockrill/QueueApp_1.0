//
//  CustomRadiusCell.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/19/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import Foundation
import UIKit

class CustomRadiusCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupFooterView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let customRadiusLabel = UILabel(text: "Custom Radius", font: UIFont.boldSystemFont(ofSize: 20))
    let radiusDescription = UILabel(text: "Only show me listings within a specific distance", font: .systemFont(ofSize: 17))
    let distanceNum: UILabel = {
        let dn = UILabel()
        dn.font = UIFont.systemFont(ofSize: 17)
        dn.textColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        return dn
    }()
    
    func setupFooterView() {
        
        let distanceSlider = UISlider()
        distanceSlider.minimumValue = 0
        distanceSlider.maximumValue = 50
        distanceSlider.isContinuous = true
        distanceSlider.tintColor = UIColor.rgb(red: 1, green: 145, blue: 244)
        distanceSlider.addTarget(self, action: #selector(sliderViewDidChange(_:)), for: .valueChanged)
        
        addSubview(customRadiusLabel)
        addSubview(radiusDescription)
        customRadiusLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: frame.width / 2, height: 20)
        radiusDescription.anchor(top: customRadiusLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 18)
        let stackView = UIStackView(arrangedSubviews: [distanceSlider, distanceNum])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        
        addSubview(stackView)
        stackView.anchor(top: radiusDescription.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 10, paddingRight: 8, width: 0, height: 0)
        
        //        distanceNum.centerYAnchor.constraint(equalTo: distanceView.centerYAnchor)
    }
    let step: Float = 1
    
    @objc func sliderViewDidChange(_ sender: UISlider!) {
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        distanceNum.text = "\(Int(roundedStepValue)) miles"
        
    }
    
}
