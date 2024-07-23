//
//  MealsContainer.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import Foundation

struct MealData: Codable, Identifiable {
    var id: String {
        idMeal
    }
    let idMeal: String
    let meal: String
    let instructions: String

    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let ingredient8: String?
    let ingredient9: String?
    let ingredient10: String?
    let ingredient11: String?
    let ingredient12: String?
    let ingredient13: String?
    let ingredient14: String?
    let ingredient15: String?
    let ingredient16: String?
    let ingredient17: String?
    let ingredient18: String?
    let ingredient19: String?
    let ingredient20: String?

    enum CodingKeys: String, CodingKey {
        case idMeal
        case meal = "strMeal"
        case instructions = "strInstructions"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
    }
    //  IMP: Commented since we are not using them for now
    //
    //    let strDrinkAlternate: String?
    //    let strCategory: String
    //    let strArea: String
    //    let strMealThumb: String
    //    let strTags: String?
    //    let strYoutube: String
    //    let strMeasure1: String?
    //    let strMeasure2: String?
    //    let strMeasure3: String?
    //    let strMeasure4: String?
    //    let strMeasure5: String?
    //    let strMeasure6: String?
    //    let strMeasure7: String?
    //    let strMeasure8: String?
    //    let strMeasure9: String?
    //    let strMeasure10: String?
    //    let strMeasure11: String?
    //    let strMeasure12: String?
    //    let strMeasure13: String?
    //    let strMeasure14: String?
    //    let strMeasure15: String?
    //    let strMeasure16: String?
    //    let strMeasure17: String?
    //    let strMeasure18: String?
    //    let strMeasure19: String?
    //    let strMeasure20: String?
    //    let strSource: String?
    //    let strImageSource: String?
    //    let strCreativeCommonsConfirmed: String?
    //    let dateModified: String?
    var allIngredients: [String] {
        let mirror = Mirror(reflecting: self)
        let ingredientProperties = mirror.children.compactMap { (label, value) -> String? in
            guard let label else { return nil }
            if label.hasPrefix("ingredient"), let ingredient = value as? String, !ingredient.isEmpty {
                return ingredient
            }
            return nil
        }
        return Array(Set(ingredientProperties))
    }
}

struct MealsContainer: Codable {
    let meals: [MealData]
}
