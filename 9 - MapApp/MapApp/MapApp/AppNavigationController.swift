//
//  AppNavigationController.swift
//  MapApp
//
//  Created by Jesse Tipton on 3/28/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit
import MapKit

class AppNavigationController: UINavigationController {
    init() {
        let rootViewController = MapSearchViewController()
        super.init(rootViewController: rootViewController)
        
        rootViewController.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
}


// MARK: - MapSearchViewControllerDelegate

extension AppNavigationController: MapSearchViewControllerDelegate {
    func openMap(with items: [MKMapItem]) {
        let mapViewController = MapViewController(mapItems: items)
        show(mapViewController, sender: self)
    }
}
