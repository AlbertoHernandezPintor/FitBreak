//
//  NewRoutineHome.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 14/2/21.
//

import SwiftUI

struct NewRoutineHome: View {
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                // Ponemos un color de fondo de pantalla
                Color.init(UIColor(named: "MainColor")!)
                
                VStack {
                    Text("Crea tus propias rutinas")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 50)
                    
                    Image(systemName: "calendar.circle")
                        .resizable()
                        .frame(width: 120, height: 120)
                    
                    NavigationLink(destination: StepOne(), tag: 1, selection: $selection) {
                        Button(action: {
                            self.selection = 1
                        }, label: {
                            Text("Crear rutina")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding()
                                .overlay(Capsule().stroke(Color.white, lineWidth: 4))
                                .background(Color.init(UIColor(named: "SecondaryColor")!))
                                .clipShape(Capsule())
                        }) // Fin Button
                        .padding(.top, 50)
                    } // Fin NavigationLink
                } // Fin VStack
            } // Fin ZStack
            .navigationTitle("Crear nueva rutina")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
        } // Fin NavigationView
    } // Fin body
} // Fin View

struct NewRoutineHome_Previews: PreviewProvider {
    static var previews: some View {
        NewRoutineHome()
    }
}
