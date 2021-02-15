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
    @Binding var shouldPopToRootView : Bool
    
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
                // Guardar en base de datos
                print(myExercises[0].reps)
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
        } // Fin VStack
        .navigationBarTitle("Paso 2", displayMode: .inline)
    } // Fin body
}

struct StepTwo_Previews: PreviewProvider {
    static var exercisesExample: [SelectedExercise] = []
    
    static var previews: some View {
        StepTwo(myExercises: exercisesExample, routineName: "Mi rutina", shouldPopToRootView: .constant(false))
            .environmentObject(ModelData())
    }
}
