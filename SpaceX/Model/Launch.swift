//
//  Launch.swift
//  SpaceX
//
//  Created by Xavier on 10/23/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

//No topLevelobject because we are dealing with a dictionary.(look at JSON)
import Foundation

struct Launch: Decodable {
    
    var missionName: String
    var launchYear: String
    let rocket: Rocket
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case launchYear = "launch_year"
        case rocket
        case links
    }
    
}

struct Rocket: Decodable {
    let rocketName: String
    
    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
    }
}

struct Links: Decodable {
    let patchImageURLAsString: String?
    
    enum CodingKeys: String, CodingKey {
        case patchImageURLAsString = "mission_patch_small"
        
    }
}


