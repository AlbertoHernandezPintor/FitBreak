//
//  MyRoutinesList.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import SwiftUI

struct MyRoutinesList: View {
    @State var myRoutines = RoutinesHandler.loadMyRoutines()
    
    var body: some View {
        List {
            ForEach(myRoutines.keys.sorted(), id: \.self) { key in
                RoutineListRow(myRoutines: $myRoutines, key: key)
            } // Fin foreach
        } // Fin list
        .onAppear() {
            myRoutines = RoutinesHandler.loadMyRoutines()
        }
    }
}

struct MyRoutinesList_Previews: PreviewProvider {
    static var previews: some View {
        MyRoutinesList()
    }
}
