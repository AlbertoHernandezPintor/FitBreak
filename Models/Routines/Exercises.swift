//
//  Exercise.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import Foundation


struct Exercises: Hashable, Codable {
    var title: String
    var exercises: [MuscleExercises]
}
