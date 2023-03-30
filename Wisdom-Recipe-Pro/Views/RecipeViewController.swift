//
//  RecipeViewController.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 29.03.2023.
//

import UIKit

class RecipeViewController: UIViewController,RecipeDelegate {
    

    // MARK: - UI Elements
    
    
    // MARK: - Properties
    var recipeList = [Recipe]()
  
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackButton()
        
    }
    
    
    // MARK: - Functions
   private func hideBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }

    //DELEGATION 
    func didAddRecipe(recipe: Recipe) {
        recipeList.append(recipe)
    }
   
    
    // MARK: - Actions

    @IBAction func addNewRecipePressed(_ sender: UIButton) {
        guard let addRecipeVC = storyboard?.instantiateViewController(withIdentifier: "addRecipeVC") as? AddRecipeViewController else { return }
        addRecipeVC.recipeDelegate = self
        navigationController?.pushViewController(addRecipeVC, animated: true)
       
    }
    
    // TODO - LATER
    @IBAction func chooseRandomFoodPressed(_ sender: UIButton) {
        
    }
}

extension RecipeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let recipeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCVC", for: indexPath) as? RecipeCollectionViewCell else {return UICollectionViewCell()}
        return recipeCVC
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 160)
    }
    
    
}




