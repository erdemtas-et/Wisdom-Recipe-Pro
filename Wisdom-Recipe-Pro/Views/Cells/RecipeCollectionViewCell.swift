//
//  RecipeCollectionViewCell.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 30.03.2023.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    
    func setup(data: Recipe) {
        foodLabel.text = data.foodName
        timeLabel.text = String(data.minute) + " min"
        difficultyLabel.text = "Difficult"
    }
    
}
