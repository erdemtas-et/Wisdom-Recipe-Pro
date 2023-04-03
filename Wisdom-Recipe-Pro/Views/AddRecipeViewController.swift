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
    
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var foodTypePickerView: UIPickerView!
    @IBOutlet var recipeTitleTF: UITextField!
    @IBOutlet var cookingTimeTF: UITextField!
    @IBOutlet var recipeURLTF: UITextField!
    
    // MARK: - Properties
    
    var recipeDelegate : RecipeDelegate!
    var foodTypes : [FoodType] = [.salad, .dessert, .dinner, .sandwich, .snack]
    var selectedImageName : String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
    }

    // MARK: - Functions
    
    func validateTextFields() {
        if recipeURLTF.text == "" || recipeTitleTF.text == "" || cookingTimeTF.text == "" {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
    }

    
    
    // MARK: - Actions

        @IBAction func addRecipePressed(_ sender: UIBarButtonItem) {
            if recipeURLTF.text == "" || recipeTitleTF.text == "" || cookingTimeTF.text == "" || cookingTimeTF.text?.rangeOfCharacter(from: CharacterSet.letters) != nil {
                showAlert(alertTitle: "Missing or Unsupported Value", alertMessage: "You have to fill the blank fields.")
            } else {
                if let recipeURL = recipeURLTF.text, let cookingTime = cookingTimeTF.text, let recipeTitle = recipeTitleTF.text, let selectedImageName = selectedImageName {
                    let selectedImage = foodImageList[selectedImageName]?.randomElement()
                    let recipe = Recipe(foodName: recipeTitle, webUrl: recipeURL, minute: cookingTime, image: UIImage(named: selectedImage!)!)
                    recipeDelegate.didAddRecipe(recipe: recipe)
                    DispatchQueue.main.async {
                        self.addButton.isEnabled = false
                        self.showConfirm()
                    }
                }
            }
        }
    }
  



    // MARK: Handle UIPickerView
extension AddRecipeViewController : UIPickerViewDelegate,UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foodTypes[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedImageName =  foodTypes[row].rawValue
    }
}

    // MARK: Handle UITextFieldDelegate
 extension AddRecipeViewController: UITextFieldDelegate {
     func textFieldDidChangeSelection(_ textField: UITextField) {
         print(textField.text)
     }
}



