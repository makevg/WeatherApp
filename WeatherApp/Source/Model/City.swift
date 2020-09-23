//
//  City.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import Foundation

struct City {
    let id: Int
    let name: String
    let country: String
    let temp: Double
    let lon: Double
    let lat: Double
    
    init(id: Int = 0, name: String, country: String = "", temp: Double = 0, lon: Double = 0, lat: Double = 0) {
        self.id = id
        self.name = name
        self.country = country
        self.temp = temp
        self.lon = lon
        self.lat = lat
    }
    
    init?(json: [String: Any]) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.country = (json["sys"] as? [String: Any])?["country"] as? String ?? ""
        self.temp = round((json["main"] as? [String: Any])?["temp"] as? Double ?? 0)
        let coord = json["coord"] as? [String: Any]
        self.lon = coord?["lon"] as? Double ?? 0
        self.lat = coord?["lat"] as? Double ?? 0
    }
}
