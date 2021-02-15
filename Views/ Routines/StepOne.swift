//
//  StepOne.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 14/2/21.
//

import SwiftUI

struct StepOne: View {
    @EnvironmentObject var modelData: ModelData
    @State var routineName: String = ""
    @State var selection: Int? = nil
    @State var myExercises: [SelectedExercise] = []
    @State private var showingAlert = false
    @State private var showingNameAlert = false
    @Binding var rootIsActive : Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Nombre de la rutina").bold()
                Divider()
                TextField("Nombre", text: $routineName)
            } // Fin HStack
            .padding(.leading, 20)
            .padding(.top, 40)
            .frame(height: 5)
            
            Spacer()
            
            List {
                ForEach(modelData.exercises, id: \.self) { exercise in
                    CategoryRow(categoryName: exercise.title, items: exercise.exercises, myExercises: $myExercises)
                }
                .frame(height: 320)
                .listRowInsets(EdgeInsets())
            }
            .padding(.top, 30)
            
            NavigationLink(destination: StepTwo(myExercises: myExercises, routineName: routineName, shouldPopToRootView: $rootIsActive), tag: 1, selection: $selection) {
                EmptyView()
            } // Fin NavigationLink
            
            Text("Siguiente")
                .foregroundColor(.white)
                .font(.title2)
                .padding()
                .overlay(Capsule().stroke(Color.white, lineWidth: 4))
                .background(Color.init(UIColor(named: "SecondaryColor")!))
                .clipShape(Capsule())
                .simultaneousGesture(TapGesture().onEnded{
                    let userDefaults = UserDefaults.standard
                    if routineName == "" {
                        showingAlert = true
                    } else if myExercises.count == 0 {
                        showingAlert = true
                    } else if userDefaults.object(forKey: routineName) != nil{
                        showingNameAlert = true
                    } else {
                        selection = 1
                    }
                })
                .padding(.top, 30)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Mensaje Importante"), message: Text("Para continuar debe elegir un nombre para la rutina y al menos un ejercicio"), dismissButton: .default(Text("Aceptar")))
                } // Fin del alert
                .alert(isPresented: $showingNameAlert) {
                    Alert(title: Text("Mensaje Importante"), message: Text("Ya existe una rutina con este nombre"), dismissButton: .default(Text("Aceptar")))
                } // Fin Alert
        } // Fin VStack
        .navigationBarTitle("Paso 1", displayMode: .inline)
    } // Fin body
} // Fin StepOne

struct StepOne_Previews: PreviewProvider {
    static var previews: some View {
        StepOne(rootIsActive: .constant(false))
            .environmentObject(ModelData())
    }
}
