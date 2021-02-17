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
    @Binding var isActive : Bool
    @State var selection: Int? = nil
    
    var body: some View {
        if let myRoutine = myRoutines[key] {
            VStack {
                Text(key)
            
                NavigationLink(destination: StepOne(routineName: key, myExercises: myRoutine, isEdit: true, rootIsActive: $isActive).environmentObject(ModelData()), tag:1, selection: $selection) {
                    EmptyView()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(myRoutine, id: \.self) { exercise in
                            RoutineListItem(exercise: exercise)
                        }
                        .padding()
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
                            RoutinesHandler.deleteRoutine(nameRoutine: key)
                        },
                        secondaryButton: .cancel(Text("Cancelar"))
                    )
                }) // Fin alert
            } // Fin VStack
            .onTapGesture {
                selection = 1
            }
        } // Fin if
    } // Fin body
}

struct RoutineListRow_Previews: PreviewProvider {
    static var previews: some View {
        RoutineListRow(myRoutines: .constant([:]), key: "Prueba", isActive: .constant(false))
    }
}
