//
//  Precipitations.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 21/2/21.
//

import Foundation

class Precipitations: Codable {
    var hasPrecipitation: Bool
    var precipitationType: String
    var precipitationIntensity: String
    
    enum CodingKeys: String, CodingKey {
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.hasPrecipitation = try container.decode(Bool.self, forKey: .hasPrecipitation)
        self.precipitationType = try container.decodeIfPresent(String.self, forKey: .precipitationType) ?? ""
        self.precipitationIntensity = try container.decodeIfPresent(String.self, forKey: .precipitationIntensity) ?? ""
    }
}
