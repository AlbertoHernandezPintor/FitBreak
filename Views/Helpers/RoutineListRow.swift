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
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack {
            Text(key)
        
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    if let myRoutine = myRoutines[key] {
                        ForEach(myRoutine, id: \.self) { exercise in
                            RoutineListItem(exercise: exercise)
                        }
                        .padding()
                    }
                } // Fin HStack
            } // Fin ScrollView
            .frame(height: 240)
            .padding(.top, 25)
            
            Button(action: {
                showingDeleteAlert = true
            }, label: {
                Text("Borrar rutina")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .overlay(Capsule().stroke(Color.white, lineWidth: 4))
                    .background(Color.init(UIColor(named: "SecondaryColor")!))
                    .clipShape(Capsule())
            }) // Fin Button
            .padding()
            .buttonStyle(BorderlessButtonStyle())
            .alert(isPresented: $showingDeleteAlert, content: {
                Alert(
                    title: Text("Borrado de rutina"),
                    message: Text("¿Seguro que desea borrar esta rutina?"),
                    primaryButton: .destructive(Text("Eliminar")) {
                        myRoutines.removeValue(forKey: key)
                        print("hola")
                        print(myRoutines)
                        RoutinesHandler.deleteRoutine(nameRoutine: key)
                    },
                    secondaryButton: .cancel(Text("Cancelar"))
                )
            }) // Fin alert
        } // Fin VStack
    }
}

struct RoutineListRow_Previews: PreviewProvider {
    static var previews: some View {
        RoutineListRow(myRoutines: .constant([:]), key: "Prueba")
    }
}
