import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @State private var mealDetail: MealDetail?
    @State private var errorMessage: String?
    
    var body: some View {
        ScrollView {
            AsyncImage(url: mealDetail?.strMealThumb) { image in
                image
                    .resizable()
            } placeholder: {
                if mealDetail?.strMealThumb != nil {
                    ProgressView()
                } else {
                    Image(systemName: "film.fill")
                }
            }
            .frame(maxWidth: 250, maxHeight: 250)
            
            Text(mealDetail?.strMeal ?? "No Name")
                .font(.title)
            
            Text("Ingredients")
                .font(.title2)
            ForEach(0..<20, id: \.self) { index in
                if let ingredients = mealDetail?.ingredients,
                       let measurements = mealDetail?.measurements,
                       index < ingredients.count, index < measurements.count {
                        Text("\(ingredients[index]) - \(measurements[index])")
                            .font(.body)
                    }
            }
            
        }
        .onAppear {
            APIService().fetchMeal(idMeal: mealId) { result in
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
    MealDetailView(mealId: "53049")
}
