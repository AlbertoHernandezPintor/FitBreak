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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tempValue = try container.decode(Double.self, forKey: .value)
        self.value = floor((tempValue - 32) * (5/9))
    }
}
