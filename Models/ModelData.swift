//
//  ModelData.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import Foundation

final class ModelData: ObservableObject {
    var exercises: [Exercises] = load("ejercicios.json")
}

// Función load para cargar un fichero, primero comprueba si existe, luego saca los datos del fichero y por último convierte los datos al tipo que infiera
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
