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
        setupTextFields()
        foodTypePickerView.selectedRow(inComponent: 0)
        addButton.isEnabled = false
    }

    // MARK: - Functions
    
    func setupTextFields() {
        recipeURLTF.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cookingTimeTF.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        recipeTitleTF.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }

    // MARK: - Actions

        @IBAction func addRecipePressed(_ sender: UIBarButtonItem) {
            if recipeURLTF.text == "" || recipeTitleTF.text == "" || cookingTimeTF.text == "" || cookingTimeTF.text?.rangeOfCharacter(from: CharacterSet.letters) != nil {
                showAlert(alertTitle: "Missing or Unsupported Value", alertMessage: "You have to fill the blank fields.")
            } else {
                if let recipeURL = recipeURLTF.text, let cookingTime = cookingTimeTF.text, let recipeTitle = recipeTitleTF.text, let selectedImageName = selectedImageName {
                        let recipe = Recipe(foodName: recipeTitle, webUrl: recipeURL, minute: cookingTime, imageName: selectedImageName)
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
     @objc func textFieldDidChange(_ textField: UITextField) {
         if recipeTitleTF.text!.isEmpty || recipeURLTF.text!.isEmpty || cookingTimeTF.text!.isEmpty{
             addButton.isEnabled = false
         } else {
             addButton.isEnabled = true
         }
     }
}



