//
//  LaunchController.swift
//  SpaceX
//
//  Created by Xavier on 10/23/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class LaunchController {
    
    //MARK: BaseURL
    static let baseURL = URL(string: "https://api.spacexdata.com/v3")
    
    static func fetchlaunches(launchYear: String, completion: @escaping ([Launch]?) -> Void) {
        
        //step 1- Construct URL
        guard var url = baseURL else { completion(nil); return }
        url.appendPathComponent("launches")
        //nEED URL COMPONENTS because we have query items
        var componets = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        //Once we have components, we can create our Query item
        let launchYearQueryItem = URLQueryItem(name: "launch_year", value: launchYear)
        // Once our query item(s) have been created, we need to add them to our components
        componets?.queryItems = [launchYearQueryItem]
        
        //Unwrap the components' url
        guard let constructedURL = componets?.url else { completion(nil); return}
        
        //We dont need a request because thre is no body and we are not passing anything tp the header. Skipping step 2
        
        // DataTask + RESUME
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion(nil); return
            }
            //Unwrap Data
            guard let data = data else { completion(nil); return}
            //Decode the data
            let decoder = JSONDecoder()
            do {
                let launches = try decoder.decode([Launch].self, from: data)
                completion(launches)
            } catch {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion(nil); return
            }
            
            
        }.resume()
    }
    
    static func fetchImages(for launch: Launch, completion: @escaping (UIImage?) -> Void) {
        
        //Construct Url
        guard let url = launch.links.patchImageURLAsString,
        let constructedURL = URL(string: url)
            else { completion(nil); return}
        
        //step 3
        URLSession.shared.dataTask(with: constructedURL) { (data, _, error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion(nil); return
            }
            guard let data = data else { completion(nil);return}
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
