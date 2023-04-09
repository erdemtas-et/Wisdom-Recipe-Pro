//
//  RecipeViewModel.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 9.04.2023.
//

import UIKit

class RecipeViewModel {
    let userDefaults = UserDefaults.standard
    var recipeList = [Recipe]()
    var filteredRecipeList = [Recipe]()
    
    var recipeCount: Int {
        return recipeList.count
    }
    
    var filteredRecipeCount : Int {
        return filteredRecipeList.count
    }
    
    func addRecipe(recipe: Recipe,collectionView : UICollectionView) {
        recipeList.append(recipe)
        collectionView.reloadData()
        setLocalData()
    }
    
    func deleteRecipe(selectedIndex: Int) {
        if !(filteredRecipeList.isEmpty){
            if let index = recipeList.firstIndex(of: (filteredRecipeList[selectedIndex])) {
                recipeList.remove(at: index)
                setLocalData()
            }
           filteredRecipeList.remove(at: selectedIndex)
            setLocalData()
        } else {
            recipeList.remove(at: selectedIndex)
            setLocalData()
        }
    }
    
    func filterRecipe(by searchText: String) {
        filteredRecipeList = recipeList.filter {
            $0.foodName.lowercased().contains(searchText.lowercased())
        }
    }
    
    func clearFilteredRecipeList() {
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
