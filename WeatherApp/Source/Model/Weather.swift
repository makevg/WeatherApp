//
//  Weather.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import Foundation

struct Weather {
    let temp: Double
    let feelsLike: Double
    let pressure: Double
    let humidity: Double
    let windSpeed: Double
    
    private(set) var info: WeatherInfo?
    private(set) var daily = [DailyWeather]()
    
    init?(json: [String: Any]) {
        guard
            let current = json["current"] as? [String: Any],
            let daily = json["daily"] as? [[String: Any]] else {
                return nil
        }
        
        self.temp = round(current["temp"] as? Double ?? 0.0)
        self.feelsLike = round(current["feels_like"] as? Double ?? 0.0)
        self.pressure = round(current["pressure"] as? Double ?? 0.0)
        self.humidity = round(current["humidity"] as? Double ?? 0.0)
        self.windSpeed = round(current["wind_speed"] as? Double ?? 0.0)
        self.info = (current["weather"] as? [[String: Any]])?.first.map { WeatherInfo(json: $0) }
        self.daily = daily.compactMap { DailyWeather(json: $0) }
    }
}
