//
//  NewRoutineView.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 14/2/21.
//

import SwiftUI

struct NewRoutineButton: View {
    var body: some View {
        Button(action: {
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
    } // Fin body
} // View

struct NewRoutineButton_Previews: PreviewProvider {
    static var previews: some View {
        NewRoutineButton()
    }
}
