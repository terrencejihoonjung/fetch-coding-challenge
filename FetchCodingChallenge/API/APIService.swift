import Foundation

class APIService {
    // Decodes fetched data into meals
    func fetchMeals(completion: @escaping (Result<Meals, Error>) -> Void) {
        performRequest(urlString: "https://" + Endpoint.baseUrl + Endpoint.meals) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(Meals.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Decodes fetched data into detailed meal
    func fetchMeal(idMeal: String, completion: @escaping (Result<MealDetails, Error>) -> Void) {
        performRequest(urlString: "https://" + Endpoint.baseUrl + Endpoint.mealDetail + idMeal) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(MealDetails.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Checks for valid URL, fetches data from API
    private func performRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data", code: -2)))
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }

}
