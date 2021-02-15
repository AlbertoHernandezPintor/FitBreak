//
//  File.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import Foundation

import SQLite

class SqlRoutinesHandler {
    static let routinesTable = Table("routines")
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let exercises = Expression<NSMutableArray>("exercises")
    
    static var database: Connection!
    
    static func createTable()-> String {
        let createTable = routinesTable.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
            table.column(id, primaryKey: true)
            table.column(name, unique: true)
            table.column(exercises)
        })
        
        return createTable
    }
    
    static func throwSqlQueries(type: String) {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let sqlFile = documentDirectory.appendingPathComponent("routines").appendingPathExtension("sqlite3")
            
            database = try Connection(sqlFile.path)
            
            if type == "createRoutineTable" {
                let createUsersTableQuery = createTable()
                try database.run(createUsersTableQuery)
            }
        } catch {
            print(error)
        }
    }
}
