//
//  MealRow.swift
//  FetchCodingChallenge
//
//  Created by Terrence Jung on 1/4/24.
//

import SwiftUI

struct MealRow: View {
    let meal: Meal
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: meal.strMealThumb) { image in
                image
                    .resizable()
            } placeholder: {
                if meal.strMealThumb != nil {
                    ProgressView()
                } else {
                    Image(systemName: "film.fill")
                }
            }
            .frame(maxWidth: 75, maxHeight: 75)
            .cornerRadius(6)
            
            VStack(alignment: .leading) {
                Text(meal.strMeal)
            }
        }
    }
}

#Preview {
    MealRow(meal: Meal(id: "53049", strMeal: "Apam balik", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")))
}
