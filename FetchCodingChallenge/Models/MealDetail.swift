import Foundation

struct MealDetailResponse: Decodable {
    let meals: [Meal]
}

struct MealDetail: Decodable {
    var idMeal: String
    var strInstructions: String
    var strMealThumb: String
    
    // Process ingredients and measurements into an array
    // compactMap transforms each element of the collection and also unwraps optionals, filtering out any 'nil' values
    // as? casts value to a String. If property is not a string or is nil, this cast fails and nil is returned
    // filter method returns new array with non-empty values
    
    var ingredients: [String] {
        Array(1...20).compactMap { self.getValue(key: "strIngredient\($0)") as? String }.filter { !$0.isEmpty }
    }

    var measurements: [String] {
        Array(1...20).compactMap { self.getValue(key: "strMeasure\($0)") as? String }.filter { !$0.isEmpty }
    }
    
    
    // Creates a mirror instance for the current object (JSON data). This allows us to access the data inside the current object.
    // We then find the first key-value pair using a key search input.
    private func getValue(key keyString: String) -> Any? {
        let mirror = Mirror(reflecting: self)
        return mirror.children.first { $0.label == keyString }?.value
    }
}
