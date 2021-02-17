//
//  CategoryItem.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import SwiftUI
import URLImage

struct CategoryItem: View {
    var exercise: MuscleExercises
    @State var color: String = "White"
    @Binding var myExercises: [SelectedExercise]
    
    var body: some View {
        ZStack {
            Color.init(UIColor(named: color)!)
            
            VStack(alignment: .leading) {
                URLImage(url: URL(string: exercise.img)!) { image in
                    image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 170, height: 170)
                        .cornerRadius(5)
                        .padding()
                }
                Text(exercise.title)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .lineLimit(4)
                    .frame(width: 180, height: 70)
                    .padding(.leading)
            } // Fin VStack
        } // Fin ZStack
        .overlay(Rectangle().stroke(lineWidth: 2))
        .frame(width: 200, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .onTapGesture {
            if color == "SecondaryColor" {
                color = "White"
                var myIndex: Int = 0;
                for currentExercise in myExercises {
                    if currentExercise.title == exercise.title {
                        myExercises.remove(at: myIndex)
                    }
                    myIndex += 1
                }
            } else {
                color = "SecondaryColor"
                var selected: SelectedExercise = SelectedExercise()
                selected.title = exercise.title
                selected.image = exercise.img
                myExercises += [selected]
            }
        }
        .onAppear(perform: {
            if myExercises.count > 0{
                for currentExercise in myExercises {
                    if currentExercise.title == exercise.title {
                        color = "SecondaryColor"
                    }
                }
            }
        })
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var exercises = ModelData().exercises
    
    static var previews: some View {
        CategoryItem(exercise: exercises[0].exercises[0], myExercises: .constant([]))
    }
}
