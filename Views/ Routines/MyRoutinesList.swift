//
//  MyRoutinesList.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import SwiftUI

struct MyRoutinesList: View {
    @State var myRoutines = RoutinesHandler.loadMyRoutines()
    @State var isActive : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if (myRoutines.keys.sorted().count != 0) {
                    Color.init(UIColor(named: "White")!)
                    
                    List {
                        ForEach(myRoutines.keys.sorted(), id: \.self) { key in
                            RoutineListRow(myRoutines: $myRoutines, key: key, isActive: $isActive)
                        } // Fin foreach
                        .padding()
                    } // Fin list
                } else {
                    Color.init(UIColor(named: "MainColor")!)
                    Text("Cree nuevas rutinas para poder visualizarlas")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                }
            } // Fin ZStack
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                myRoutines = RoutinesHandler.loadMyRoutines()
            } // Fin onAppear
            .navigationTitle("Mis rutinas")
            .navigationBarHidden(true)
        } // Fin navigationView
    }
}

struct MyRoutinesList_Previews: PreviewProvider {
    static var previews: some View {
        MyRoutinesList()
            .environmentObject(ModelData())
    }
}
