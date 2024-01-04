import SwiftUI

struct MealListView: View {
    // Meals Data
    @State private var meals: [Meal] = []
    @State private var errorMessage: String?
    
    private var sortedMeals: [Meal] {
        meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    var body: some View {
        NavigationView {
            List(sortedMeals, id: \.id) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.id)) {
                    MealRow(meal: meal)
                }
            }
            .navigationTitle("Meals")
            .onAppear {
                APIService().fetchMeals { result in
                    switch result {
                    case .success(let fetchedMeals):
                        self.meals = fetchedMeals.meals
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        // Handle the error, e.g., show an alert
                    }
                }
            }
        }
    }
}

#Preview {
    MealListView()
}
