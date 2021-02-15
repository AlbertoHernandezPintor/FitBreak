//
//  RoutineExerciseRow.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import SwiftUI
import URLImage

struct RoutineExerciseRow: View {
    @Binding var myExercises: [SelectedExercise]
    @State var index: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                URLImage(url: URL(string: myExercises[index].image)!) { image in
                    image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 170, height: 170)
                        .cornerRadius(5)
                        .padding()
                }
                Text(myExercises[index].title)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .lineLimit(4)
                    .frame(width: 180, height: 70)
                    .padding(.leading)
            } // Fin VStack
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Series").bold()
                    Divider()
                    TextField("Series", text: $myExercises[index].sets)
                } // Fin HStack
                .frame(height: 30)
                .padding()
                .keyboardType(.numberPad)
                
                HStack {
                    Text("Reps").bold()
                    Divider()
                    TextField("Reps", text: $myExercises[index].reps)
                } // Fin HStack
                .frame(height: 30)
                .padding()
                .keyboardType(.numberPad)
                
                HStack {
                    Text("Peso").bold()
                    Divider()
                    TextField("Peso", text: $myExercises[index].weight)
                } // Fin HStack
                .frame(height: 30)
                .padding()
                .keyboardType(.decimalPad)
            } // Fin VStack
        } // Fin HStack
    } // Fin body
}

struct RoutineExerciseRow_Previews: PreviewProvider {
    static var exercise: SelectedExercise = SelectedExercise()
    
    static var previews: some View {
        RoutineExerciseRow(myExercises: .constant([]), index: 0)
    }
}
