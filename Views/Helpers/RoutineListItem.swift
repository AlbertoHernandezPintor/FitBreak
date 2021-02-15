//
//  RoutineListItem.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import SwiftUI
import URLImage

struct RoutineListItem: View {
    @State var exercise: SelectedExercise
    
    var body: some View {
        HStack {
            VStack {
                URLImage(url: URL(string: exercise.image)!) { image in
                    image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 170, height: 170)
                        .cornerRadius(5)
                        .padding(.bottom, 0)
                } // Fin imagen
                Text(exercise.title)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .lineLimit(4)
                    .frame(width: 180, height: 70)
                    .padding(.leading)
                    .padding(.top, 0)
            } // Fin VStack
            
            VStack {
                HStack {
                    Text("Sets").bold()
                    Divider()
                    Text(exercise.sets)
                }
                .frame(height: 20)
                .padding()
                
                HStack {
                    Text("Reps").bold()
                    Divider()
                    Text(exercise.reps)
                }
                .frame(height: 20)
                .padding()
                
                HStack {
                    Text("Peso").bold()
                    Divider()
                    Text(exercise.weight)
                }
                .frame(height: 20)
                .padding()
            } // Fin VStack
            .padding()
            Divider()
        } // Fin HStack
    } // Fin body
}

struct RoutineListItem_Previews: PreviewProvider {
    static var previews: some View {
        RoutineListItem(exercise: SelectedExercise())
    }
}
