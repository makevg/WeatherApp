//
//  WeatherUrlFactory.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import Foundation

final class WeatherUrlFactory {
    
    enum UrlType {
        case find(query: String)
        case forecast(query: String)
        case weather(query: String)
        case onecall(location: (lat: Double, lon: Double))
        case img(imageName: String)
        
        var stringValue: String {
            switch self {
            case .find:
                return "find"
            case .forecast:
                return "forecast"
            case .weather:
                return "weather"
            case .onecall:
                return "onecall"
            case .img:
                return "img/wn/"
            }
        }
    }
    
    private struct Constants {
        static let imageDomain = "https://openweathermap.org/"
        static let domain = "http://api.openweathermap.org/data/2.5/"
        static let appId = "appid=a8edcd021355db7267eddade60f450be"
        static let lang = "lang=ru"
        static let units = "units=metric"
    }
    
    static func url(by type: UrlType) -> String {
        let queryStr: String
        
        switch type {
        case .find(let query), .forecast(let query), .weather(let query):
            queryStr = "q=\(query)"
        case .onecall(let location):
            queryStr = "lat=\(location.lat)&lon=\(location.lon)"
        case .img(let imageName):
            return "\(Constants.imageDomain)\(type.stringValue)\(imageName)@2x.png"
        }
        
        return "\(Constants.domain)\(type.stringValue)?\(queryStr)&\(Constants.appId)&\(Constants.lang)&\(Constants.units)"
    }
}
