//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import Foundation

struct DailyWeather {
    let date: Date
    let tempMax: Double
    let tempMin: Double
    
    var info: WeatherInfo?
    
    init?(json: [String: Any]) {
        guard let dt = json["dt"] as? Double,
            let temp = json["temp"] as? [String: Any] else {
            return nil
        }
        
        self.date = Date(timeIntervalSince1970: dt)
        self.tempMax = temp["max"] as? Double ?? 0.0
        self.tempMin = temp["min"] as? Double ?? 0.0
        self.info = (json["weather"] as? [[String: Any]])?.first.map { WeatherInfo(json: $0) }
    }
}
