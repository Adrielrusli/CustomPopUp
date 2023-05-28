import Foundation
import SwiftUI

//struct MealsResponse: Codable {
//    let meals: [Meal]
//}
//
//struct Meal: Codable {
//    let idMeal: String
//    let strMeal: String
//    let strCategory: String
//    let strInstructions: String
//    // Add other properties as needed
//}
//
//struct MealFetcher {
//    func fetchMeals(completion: @escaping ([Meal]?) -> Void) {
//        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=chicken") else {
//            completion(nil)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching meals: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(MealsResponse.self, from: data)
//                let meals = response.meals
//                completion(meals)
//            } catch {
//                print("Error decoding meals response: \(error.localizedDescription)")
//                completion(nil)
//            }
//        }.resume()
//    }
//}
//
//struct ContentView: View {
//    @State private var meals: [Meal] = []
//
//    var body: some View {
//        List(meals, id: \.idMeal) { meal in
//            VStack(alignment: .leading) {
//                Text(meal.idMeal)
//                    .font(.headline)
//                Text(meal.strCategory)
//                    .font(.subheadline)
//                Text(meal.strInstructions)
//                    .font(.body)
//            }
//        }
//        .onAppear {
//            MealFetcher().fetchMeals { fetchedMeals in
//                if let fetchedMeals = fetchedMeals {
//                    DispatchQueue.main.async {
//                        meals = fetchedMeals
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//

import Foundation
import SwiftUI

struct MealsResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strInstructions: String
    // Add other properties as needed
    
    var id: String { idMeal }
}

struct MealFetcher {
    
    let ind = "rendang"
    func fetchMeals(completion: @escaping ([Meal]?) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(ind)") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching meals: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MealsResponse.self, from: data)
                let meals = response.meals
                completion(meals)
            } catch {
                print("Error decoding meals response: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}

struct ContentView: View {
    @State private var meals: [Meal] = []

    var body: some View {
        NavigationView {
            List(meals) { meal in
                NavigationLink(destination: RecipeDetailView(meal: meal)) {
                    Text(meal.strMeal)
                        .font(.headline)
                }
            }
            .navigationBarTitle("Recipes")
            .onAppear {
                MealFetcher().fetchMeals { fetchedMeals in
                    if let fetchedMeals = fetchedMeals {
                        DispatchQueue.main.async {
                            meals = fetchedMeals
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RecipeDetailView: View {
    let meal: Meal
    
    var body: some View {
        VStack {
            Text(meal.strMeal)
                .font(.headline)
            Text(meal.strCategory)
                .font(.subheadline)
            Text(meal.strInstructions)
                .font(.body)
        }
        .navigationBarTitle(meal.strMeal)
    }
}
