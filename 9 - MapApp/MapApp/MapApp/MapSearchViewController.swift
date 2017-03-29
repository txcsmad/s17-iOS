//
//  MapSearchViewController.swift
//  MapApp
//
//  Created by Jesse Tipton on 3/28/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import UIKit
import MapKit

protocol MapSearchViewControllerDelegate: class {
    func openMap(with items: [MKMapItem])
}

class MapSearchViewController: UITableViewController {
    
    private var mapItems = [MKMapItem]()
    private let cellIdentifier = String(describing: MapItemTableViewCell.self) // "MapItemTableViewCell"
    
    weak var delegate: MapSearchViewControllerDelegate?
    
    init() {
        super.init(style: .plain)
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        
        let mapBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(openMap))
        navigationItem.rightBarButtonItem = mapBarButtonItem
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "tacos"
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let `self` = self else {
                return
            }
            
            guard let response = response else {
                print(error!)
                return
            }
            
            self.mapItems = response.mapItems
            self.tableView.reloadData()
        }
    }
    
    func openMap() {
        delegate?.openMap(with: mapItems)
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let mapItem = mapItems[indexPath.row]
        
        cell.textLabel?.text = mapItem.name
        cell.detailTextLabel?.text = mapItem.phoneNumber
        if let _ = mapItem.url {
            cell.accessoryType = .detailButton
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let mapItem = mapItems[indexPath.row]
        if let url = mapItem.url {
            UIApplication.shared.open(url)
        }
    }
    
}
