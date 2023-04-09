//
//  RecipeViewController.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 29.03.2023.
//

import UIKit

class MainViewController: UIViewController,RecipeDelegate, UIGestureRecognizerDelegate {
    
    
    // MARK: - UI Elements
    
    @IBOutlet var recipeCollectionView: UICollectionView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var conditionLabel: UILabel!
    
    // MARK: - Properties
    var recipeViewModel = RecipeViewModel()
  
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackButton()
        hideKeyboard()
        checkCountCondition()
        searchTextField.delegate = self
        
        
        recipeViewModel.loadLocalData()
        
        
        func setupLongGestureRecognizerOnCollection() {
                let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
                longPressedGesture.minimumPressDuration = 0.5
                longPressedGesture.delegate = self
                longPressedGesture.delaysTouchesBegan = true
                recipeCollectionView.addGestureRecognizer(longPressedGesture)
            }
            setupLongGestureRecognizerOnCollection()
    }
    
    // MARK: - Functions
   private func hideBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
 
    private func invalidFilterResult() {
        conditionLabel.isHidden = true
        recipeCollectionView.isHidden = false
    }
   
    
  
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }
        let p = gestureRecognizer.location(in: recipeCollectionView)
        if let indexPath = recipeCollectionView.indexPathForItem(at: p) {
            deleteAlert(alertTitle: "Delete Recipe", alertMessage: "Would you like to delete this recipe?", collectionView: recipeCollectionView, selectedIndex: indexPath.row)
        }
    }
    
    func deleteAlert(alertTitle: String,alertMessage: String,collectionView: UICollectionView,selectedIndex : Int) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { [self]_ in
           
            recipeViewModel.deleteRecipe(selectedIndex: selectedIndex)
            recipeCollectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }


    //DELEGATION
    func didAddRecipe(recipe: Recipe) {
        recipeViewModel.addRecipe(recipe: recipe,collectionView: recipeCollectionView)
        checkCountCondition()
    }
    
    func checkCountCondition() {
        if recipeViewModel.recipeCount == 0 {
            conditionLabel.text = "You don't have any saved recipe."
        }
        else  {
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

    // MARK: - Extensions

extension MainViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeViewModel.filteredRecipeCount != 0 ? recipeViewModel.filteredRecipeCount : recipeViewModel.recipeCount
    }
    
    // Collection View Data Fill
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let recipeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCVC", for: indexPath) as? RecipeCollectionViewCell else {return UICollectionViewCell()}
        
        if !recipeViewModel.filteredRecipeList.isEmpty {
            let currentRecipe = recipeViewModel.filteredRecipeList[indexPath.row]
            recipeCVC.setup(data: currentRecipe)
            invalidFilterResult()
            
        } else if searchTextField.text != "" && recipeViewModel.filteredRecipeList.isEmpty {
            conditionLabel.isHidden = false
            conditionLabel.text = "Couldn't find any recipe in this name"
            collectionView.isHidden = true
        }
        else {
            if recipeViewModel.recipeCount > 0 {
                let currentRecipe = recipeViewModel.recipeList[indexPath.row]
                recipeCVC.setup(data: currentRecipe)
                invalidFilterResult()
            }
        }
        return recipeCVC
    }
    
    // Collection View Selected Cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        guard let recipeDetailsVC = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController else {return}
        
        if !recipeViewModel.filteredRecipeList.isEmpty {
            recipeDetailsVC.urlString = recipeViewModel.filteredRecipeList[indexPath.row].webUrl
        } else {
            recipeDetailsVC.urlString = recipeViewModel.recipeList[indexPath.row].webUrl
        }
        present(recipeDetailsVC, animated: true)
    }
    
    // Collection View UI Setup
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

    //Text Field Delegation
extension MainViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if searchTextField.text != "",let searchTFValue = searchTextField.text {
            recipeViewModel.filterRecipe(by: searchTFValue)
        }
        else {
            recipeViewModel.clearFilteredRecipeList()
        }
        recipeCollectionView.reloadData()
    }
}




