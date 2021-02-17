//
//  StepTwo.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import SwiftUI

struct StepTwo: View {
    @State var myExercises: [SelectedExercise]
    @State var routineName: String
    @State var editName: String
    @Binding var shouldPopToRootView : Bool
    @State var isEdit: Bool
    @Environment(\.presentationMode) var presentationMode
    @Binding var finishEdit: Bool
    @State var showEditAlert = false
    
    var body: some View {
        VStack {
            List {
                ForEach(0..<myExercises.count) { index in
                    RoutineExerciseRow(myExercises: $myExercises, index: index)
                }
                .frame(height: 320)
                .listRowInsets(EdgeInsets())
            }
            
            Button(action: {
                if isEdit {
                    finishEdit = true
                    RoutinesHandler.deleteRoutine(nameRoutine: editName)
                    RoutinesHandler.saveRoutine(name: routineName, exercises: myExercises)
                    RoutinesHandler.saveRoutineName(name: routineName)
                    showEditAlert = true
                    presentationMode.wrappedValue.dismiss()
                } else {
                    RoutinesHandler.saveRoutine(name: routineName, exercises: myExercises)
                    RoutinesHandler.saveRoutineName(name: routineName)
                }
                shouldPopToRootView = false
            }, label: {
                Text("Terminar")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .overlay(Capsule().stroke(Color.white, lineWidth: 4))
                    .background(Color.init(UIColor(named: "SecondaryColor")!))
                    .clipShape(Capsule())
            }) // Fin Button
            .padding(.top, 30)
            .alert(isPresented: $showEditAlert) {
                Alert(title: Text("Mensaje Importante"), message: Text("Rutina editada con exito"), dismissButton: .default(Text("Aceptar")))
            } // Fin Alert
        } // Fin VStack
        .navigationBarTitle("Paso 2", displayMode: .inline)
        .padding()
    } // Fin body
}

struct StepTwo_Previews: PreviewProvider {
    static var exercisesExample: [SelectedExercise] = []
    
    static var previews: some View {
        StepTwo(myExercises: exercisesExample, routineName: "Mi rutina", editName: "Prueba", shouldPopToRootView: .constant(false), isEdit: false, finishEdit: .constant(false))
            .environmentObject(ModelData())
    }
}
