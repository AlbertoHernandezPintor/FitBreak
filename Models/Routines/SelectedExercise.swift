//
//  SelectedExercise.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import Foundation

struct SelectedExercise : Hashable, Codable {
    var title: String = ""
    var image: String = ""
    var reps: String = ""
    var sets: String = ""
    var weight: String = ""
}
