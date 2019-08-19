//
//  MapViewHeader.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/19/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import MapKit

class MapViewHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var mapView = MKMapView()
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        addSubview(mapView)
        mapView.fillSuperview()
        
        // Or, if needed, we can position map in the center of the view
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
