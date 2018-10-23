//
//  LaunchTableViewCell.swift
//  SpaceX
//
//  Created by Xavier on 10/23/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    
    //LandingPad
    var launch: Launch? {
        didSet{
            updateViews(launch: launch)
        }
    }
    //Landing Pad for patch image
    var patchImage: UIImage? {
        didSet{
            updateViews(patchImage: patchImage)
            
        }
    }
    
    //Mark: OUTLETS
    @IBOutlet weak var patchImageView: UIImageView!
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var launchYearLabel: UILabel!
    
    
    func updateViews(launch: Launch? = nil, patchImage: UIImage? = nil) {
        DispatchQueue.main.async {
            if let launch = launch {
                self.missionNameLabel.text = launch.missionName
                self.rocketNameLabel.text = launch.rocket.rocketName
                self.launchYearLabel.text = launch.launchYear
            } else if let patchImage = patchImage {
                self.patchImageView.image = patchImage
            }
        }
    }
}
