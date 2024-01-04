import SwiftUI

struct MealDetailView: View {
    let meal: MealDetail
    @State private var mealDetail: MealDetail?
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            AsyncImage(url: meal.strMealThumb) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 250, maxHeight: 250)
            
            Text(meal.strMeal)
                .font(.title)
            
            Text("Ingredients")
                .font(.title2)
            ForEach(meal.ingredients) { ingredient in
                Text(ingredientDisplay(ingredient))
                    .font(.body)
            }
            
        }
        .onAppear {
            APIService().fetchMeal(idMeal: meal.id) { result in
                switch result {
                case .success(let mealDetails):
                    self.mealDetail = mealDetails.meals[0]
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    MealDetailView(mealId: "test")
}
