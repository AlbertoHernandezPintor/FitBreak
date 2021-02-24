//
//  WeatherModel.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 21/2/21.
//

import Foundation

class WeatherModel: Codable {
    var dailyForecasts: [DailyForecast]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}
