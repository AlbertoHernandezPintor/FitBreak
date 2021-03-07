//
//  LandmarkAnnotation.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 7/3/21.
//

import Foundation
import MapKit
import UIKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}
