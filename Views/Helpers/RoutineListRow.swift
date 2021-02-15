//
//  RoutineListRow.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import SwiftUI

struct RoutineListRow: View {
    @Binding var myRoutines: [String:[SelectedExercise]]
    @State var key: String
    
    var body: some View {
        VStack {
            Text(key)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(myRoutines[key]!, id: \.self) { exercise in
                        RoutineListItem(exercise: exercise)
                    }
                } // Fin HStack
            } // Fin ScrollView
            .frame(height: 240)
            .padding(.top, 25)
        } // Fin VStack
    }
}

struct RoutineListRow_Previews: PreviewProvider {
    static var previews: some View {
        RoutineListRow(myRoutines: .constant([:]), key: "Prueba")
    }
}
