//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import Foundation

struct WeatherInfo {
    let description: String
    let icon: String
    let iconUrl: String
    
    init(json: [String: Any]) {
        self.description = json["description"] as? String ?? ""
        self.icon = json["icon"] as? String ?? ""
        self.iconUrl = WeatherUrlFactory.url(by: .img(imageName: icon))
    }
}
