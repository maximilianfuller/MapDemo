//
//  MapViewController.swift
//  MapDemo
//
//  Created by Max Fuller on 2/21/18.
//  Copyright © 2018 Max Fuller. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController : UIViewController {
    override func loadView() {
        initMap()
    }
    
    func initMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 37.75, longitude: -122.45, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let data = DataManager.instance.data
        for d in data {
            let latLong = d[DataManager.instance.locationColumnIndex]
            var latLongArr = latLong.components(separatedBy: ", ")
            if latLongArr.count != 2 {
                continue
            }
            guard let lat = Double(latLongArr[0].trimmingCharacters(in: .whitespaces)) else {
                return
            }
            guard let long = Double(latLongArr[1].trimmingCharacters(in: .whitespaces)) else {
                return
            }
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
        }
        
    }
}
