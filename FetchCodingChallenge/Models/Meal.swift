import Foundation

// Decodable protocol makes it possible to decpde KSPM data into model objects
// Identifiable protocol is used to uniquely identify elements

struct Meals: Decodable {
    let meals: [Meal]
}

struct Meal: Identifiable, Decodable {
    var id: String
    var strMeal: String
    var strMealThumb: String
    
    // CodingKeys maps JSON key "idMeal" to Meal property "id" -> allows us to conform to Identifiable protocol
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strMealThumb
    }
}
