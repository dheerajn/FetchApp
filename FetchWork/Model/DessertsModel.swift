//
//  DessertsModel.swift
//  Fetch
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import Foundation

struct Desserts: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String

    var id: String {
        idMeal
    }
}
