//
//  LaunchTableViewController.swift
//  SpaceX
//
//  Created by Xavier on 10/23/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class LaunchTableViewController: UITableViewController {
    
    //MARK: Con
    var launches: [Launch] = []
    
    @IBOutlet weak var launchSearchbar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchSearchbar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return launches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "launchCell", for: indexPath) as? LaunchTableViewCell else { return UITableViewCell()}
        
        let launch = launches[indexPath.row]
        cell.launch = launches[indexPath.row]
        
        LaunchController.fetchImages(for: launch) { (patchImage) in
            if let patchImage = patchImage {
                cell.patchImage = patchImage
            }
        }
        return cell
    }
}

extension LaunchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let launchYear = searchBar.text else { return}
        searchBar.text = ""
        searchBar.resignFirstResponder()
        LaunchController.fetchlaunches(launchYear: launchYear) { (launches) in
            guard let launches = launches else { return}
            
            self.launches = launches
            
            DispatchQueue.main.async {
                //Need self because we are inside a closure
                self.tableView.reloadData()
            }
        }
    }
}
