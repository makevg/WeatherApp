//
//  Date+Extensions.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import Foundation

extension Date {
    
    var dateFormattedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        
        return dateFormatter.string(from: self)
    }
    
    var weekDayFormattedString: String {
        let dayFormatter = DateFormatter()
        dayFormatter.locale = Locale(identifier: "ru_RU")
        dayFormatter.dateFormat = "EEEE"
        
        return dayFormatter.string(from: self)
    }
}
