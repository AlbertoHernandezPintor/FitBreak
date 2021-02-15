//
//  CategoryRow.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 15/2/21.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [MuscleExercises]
    @Binding var myExercises: [SelectedExercise]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items, id: \.self) { exercise in
                        CategoryItem(exercise: exercise, myExercises: $myExercises)
                    }
                }
            }
            .frame(height: 185)
            .padding(.top, 50)
        } // Fin VStack
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var exercises = ModelData().exercises
    
    static var previews: some View {
        CategoryRow(categoryName: exercises[0].title, items: exercises[0].exercises, myExercises: .constant([]))
    }
}
