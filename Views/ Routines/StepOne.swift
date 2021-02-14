//
//  StepOne.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 14/2/21.
//

import SwiftUI

struct StepOne: View {
    var body: some View {
        NavigationView {
            Text("Hola")
        } // Fin NavigationView
        .navigationBarTitle("Paso 1", displayMode: .inline)
    } // Fin body
} // Fin StepOne

struct StepOne_Previews: PreviewProvider {
    static var previews: some View {
        StepOne()
    }
}
