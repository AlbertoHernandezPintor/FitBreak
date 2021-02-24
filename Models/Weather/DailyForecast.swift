//
//  DailyForecast.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 21/2/21.
//

import Foundation

class DailyForecast: Codable {
    var date: String
    var temperature: Temperature
    var day: Precipitations
    var night: Precipitations
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .date)
        self.temperature = try container.decode(Temperature.self, forKey: .temperature)
        self.day = try container.decode(Precipitations.self, forKey: .day)
        self.night = try container.decode(Precipitations.self, forKey: .night)
        self.date = dateString.components(separatedBy: "T")[0]
    }
}
