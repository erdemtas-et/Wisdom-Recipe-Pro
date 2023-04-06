//
//  RecipeViewController.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 29.03.2023.
//

import UIKit

class RecipeViewController: UIViewController,RecipeDelegate {
    

    // MARK: - UI Elements
    
    @IBOutlet var recipeCollectionView: UICollectionView!
    @IBOutlet var conditionLabel: UILabel!
    
    // MARK: - Properties
    var recipeList = [Recipe]()
    let userDefaults = UserDefaults.standard
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackButton()
        checkCountCondition()
        
        do {
            if let savedData = userDefaults.object(forKey: "Recipes") as? Data {
                let decodedData = try JSONDecoder().decode([Recipe].self, from: savedData)
                recipeList = decodedData
                checkCountCondition()
            }
            
        } catch  {
            print("error")
        }
       
       
    }
    
    
    // MARK: - Functions
   private func hideBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }

    //DELEGATION
    func didAddRecipe(recipe: Recipe) {
        recipeList.append(recipe)
        checkCountCondition()
        recipeCollectionView.reloadData()
        
        do {
         let recipeUD =  try JSONEncoder().encode(recipeList)
            userDefaults.set(recipeUD, forKey: "Recipes")
        } catch  {
           print("error")
        }
          
        
    }
   
    
    func checkCountCondition() {
        if recipeList.count == 0 {
            conditionLabel.text = "You don't have any saved recipe."
        } else {
            conditionLabel.isHidden = true
        }
    }
    
    // MARK: - Actions

    @IBAction func addNewRecipePressed(_ sender: UIBarButtonItem) {
        guard let addRecipeVC = storyboard?.instantiateViewController(withIdentifier: "addRecipeVC") as? AddRecipeViewController else { return }
        addRecipeVC.recipeDelegate = self
        navigationController?.pushViewController(addRecipeVC, animated: true)
    }
}

extension RecipeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let recipeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCVC", for: indexPath) as? RecipeCollectionViewCell else {return UICollectionViewCell()}
        if recipeList.count > 0 {
            let currentRecipe = recipeList[indexPath.row]
            recipeCVC.setup(data: currentRecipe)
        }
        return recipeCVC
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        guard let recipeDetailsVC = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController else {return}
        recipeDetailsVC.urlString = recipeList[indexPath.row].webUrl
        present(recipeDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    
    
}




