//
//  Degrees.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 21/2/21.
//

import Foundation

class Degrees: Codable {
    var value: Double
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}
