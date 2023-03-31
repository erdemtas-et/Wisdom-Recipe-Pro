//
//  AddRecipeViewController.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 30.03.2023.
//

import UIKit

protocol RecipeDelegate {
    func didAddRecipe(recipe: Recipe)
}

class AddRecipeViewController: UIViewController {

   
    // MARK: - UI Elements
    
    @IBOutlet var recipeTitleTF: UITextField!
    @IBOutlet var cookingTimeTF: UITextField!
    @IBOutlet var recipeURLTF: UITextField!
    
    // MARK: - Properties
    
    var recipeDelegate : RecipeDelegate!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Functions
    
    func showAlert(alertTitle: String,alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    


    // MARK: - Actions

    @IBAction func addRecipePressed(_ sender: UIButton) {
        if recipeURLTF.text == "" || recipeTitleTF.text == "" || cookingTimeTF.text == "" || cookingTimeTF.text?.rangeOfCharacter(from: CharacterSet.letters) != nil {
            showAlert(alertTitle: "Missing or Unsupported Value", alertMessage: "You have to fill the blank fields.")
        } else {
            if let recipeURL = recipeURLTF.text, let cookingTime = cookingTimeTF.text, let recipeTitle = recipeTitleTF.text {
              
                recipeDelegate.didAddRecipe(recipe: recipe)
                navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    @IBAction func cancelRecipePressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}



