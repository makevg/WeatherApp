//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import Alamofire

final class WeatherService {
    
    func getCities(query: String, completion: @escaping ([City]) -> Void) {
        AF.request(.find(query: query)) { json in
            guard let list = json["list"] as? [[String: Any]] else {
                return
            }
            
            let cities = list.compactMap { City(json: $0) }
            
            completion(cities)
        }
    }
    
    func getWeather(for location: (lat: Double, lon: Double), completion: @escaping (Weather) -> Void) {
        AF.request(.onecall(location: location)) { json in
            guard let weather = Weather(json: json) else {
                return
            }
            
            completion(weather)
        }
    }
}

// MARK: - Extrnsions

private extension Session {
    
    func request(_ urlType: WeatherUrlFactory.UrlType, completion: @escaping (([String: Any]) -> Void)) {
        request(WeatherUrlFactory.url(by: urlType)).responseJSON { data in
            guard let json = data.value as? [String: Any] else {
                return
            }
            
            completion(json)
        }
    }
}
