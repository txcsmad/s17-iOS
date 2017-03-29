//
//  MapViewController.swift
//  MapApp
//
//  Created by Jesse Tipton on 3/28/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let mapItems: [MKMapItem]
    
    init(mapItems: [MKMapItem]) {
        self.mapItems = mapItems
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func setUp() {
        let map = MKMapView()
        
        view.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let placemarks = mapItems.map { item -> MKPlacemark in
            return item.placemark
        }
        
        map.addAnnotations(placemarks)
        map.showAnnotations(placemarks, animated: true)
    }
    
}
