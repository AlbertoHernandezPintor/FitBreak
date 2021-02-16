//
//  RoutinesHandler.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import Foundation

class RoutinesHandler {
    static func saveRoutine(name: String, exercises: [SelectedExercise]) {
        let usersDefaults = UserDefaults.standard
        let exercisesData = try! JSONEncoder().encode(exercises)
        usersDefaults.set(exercisesData, forKey: name)
    }
    
    static func loadMyRoutines()->[String:[SelectedExercise]] {
        let usersDefaults = UserDefaults.standard
        var myRoutines = [String:[SelectedExercise]]()
        
        if let routinesName = usersDefaults.array(forKey: "allRoutinesName") {
            for (key, _) in usersDefaults.dictionaryRepresentation() {
                for name in routinesName {
                    if key == name as! String {
                        let exercisesData = usersDefaults.data(forKey: key)
                        let exercises = try! JSONDecoder().decode([SelectedExercise].self, from: exercisesData!)
                        myRoutines[key] = exercises
                    }
                }
            }
        }
        
        return myRoutines
    }
    
    static func saveRoutineName(name: String) {
        let usersDefaults = UserDefaults.standard
        if var routinesName = usersDefaults.array(forKey: "allRoutinesName") {
            routinesName += [name]
            usersDefaults.setValue(routinesName, forKey: "allRoutinesName")
        } else {
            usersDefaults.setValue([name], forKey: "allRoutinesName")
        }
    }
    
    static func deleteRoutine(nameRoutine: String) {
        let usersDefaults = UserDefaults.standard
        usersDefaults.removeObject(forKey: nameRoutine)
        
        if var routinesName = usersDefaults.array(forKey: "allRoutinesName") {
            for (index, element) in routinesName.enumerated() {
                if nameRoutine == element as! String {
                    routinesName.remove(at: index)
                }
            }
        }
    }
}
