//
//  Temperatures.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 21/2/21.
//

import Foundation

class Temperature: Codable {
    var minimum: Degrees
    var maximum: Degrees
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}
