//
//  MapViewHeader.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/19/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class MapViewHeader: UICollectionReusableView, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var marker = GMSMarker()
    var zoomLevel: Float = 15.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        GMSServices.provideAPIKey("AIzaSyB15PqK1-_nrbU9Ium_T1utrrxGTV4VDNw")
        let camera = GMSCameraPosition.camera(withLatitude: 38.8462236, longitude:  -77.3063733, zoom: 10)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.distanceFilter = 50
//        locationManager.startUpdatingLocation()
//        locationManager.delegate = self
//
//        placesClient = GMSPlacesClient.shared()
        
        addSubview(mapView)
        mapView.fillSuperview()
        
        let currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(38.8462236, -77.3063733)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "SFO Airport"
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.map = mapView
        marker.appearAnimation = GMSMarkerAnimation.pop
        drawCircle(position: currentLocation)
    }
    
    func drawCircle(position: CLLocationCoordinate2D) {
        
        //var latitude = position.latitude
        //var longitude = position.longitude
        //var circleCenter = CLLocationCoordinate2DMake(latitude, longitude)
        var circle = GMSCircle(position: position, radius: 3000)
        circle.strokeColor = UIColor.blue
        circle.fillColor = UIColor(red: 0, green: 0, blue: 0.35, alpha: 0.2)
        circle.map = mapView
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
