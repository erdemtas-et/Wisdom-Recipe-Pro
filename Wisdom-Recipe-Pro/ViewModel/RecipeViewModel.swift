//
//  RecipeViewModel.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 9.04.2023.
//

import Foundation

class RecipeViewModel {
    let userDefaults = UserDefaults.standard
    var recipeList = [Recipe]()
    var filteredRecipeList = [Recipe]()
    
    var recipeCount: Int {
        return recipeList.count
    }
    
    func recipe(at index: Int) -> Recipe {
        return filteredRecipeList.isEmpty ? recipeList[index] : filteredRecipeList[index]
    }
    
    func add(recipe: Recipe) {
        recipeList.append(recipe)
        setLocalData()
    }
    
    func delete(recipe: Recipe) {
        if let index = recipeList.firstIndex(of: recipe) {
            recipeList.remove(at: index)
            setLocalData()
        }
    }
    
    func filter(by searchText: String) {
        filteredRecipeList = recipeList.filter {
            $0.foodName.lowercased().contains(searchText.lowercased())
        }
    }
    
    func clearFilter() {
        filteredRecipeList.removeAll()
    }
    
    func setLocalData() {
        do {
            let recipeUD =  try JSONEncoder().encode(recipeList)
            userDefaults.set(recipeUD, forKey: "Recipes")
        } catch  {
            print("error")
        }
    }
    
    func loadLocalData() {
        do {
            if let savedData = userDefaults.object(forKey: "Recipes") as? Data {
                let decodedData = try JSONDecoder().decode([Recipe].self, from: savedData)
                recipeList = decodedData
            }
        } catch  {
            print("error")
        }
    }
}
