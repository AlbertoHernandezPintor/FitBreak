//
//  NewWeather.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 24/2/21.
//

import Foundation

class NewWeather: Codable {
    var dailyForecasts: DailyForecast
    var country: String
    var city: String
    
    init(dailyForecasts: DailyForecast, country: String, city: String) {
        self.dailyForecasts = dailyForecasts
        self.country = country
        self.city = city
    }
}
