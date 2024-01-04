import Foundation

struct MealDetails: Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Identifiable, Decodable {
    var id: String
    var strMeal: String
    var strInstructions: String
    var strMealThumb: String
    
    // Computed properties to put ingredients and measurements into arrays
    var ingredients: [String] {
        (1...20).compactMap { self.value(forKey: "strIngredient\($0)") as? String }.filter { !$0.isEmpty }
    }

    var measurements: [String] {
        (1...20).compactMap { self.value(forKey: "strMeasure\($0)") as? String }.filter { !$0.isEmpty }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strInstructions
        case strMealThumb
    }
    
    // Get value for a given key
    private func value(forKey key: String) -> Any? {
        let mirror = Mirror(reflecting: self)
        return mirror.children.first { $0.label == key }?.value
    }
}
