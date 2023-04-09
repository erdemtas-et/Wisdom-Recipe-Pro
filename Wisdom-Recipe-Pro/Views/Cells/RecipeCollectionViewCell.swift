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
    @IBOutlet var foodImage: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        cellUISetup()
        }

    func setup(data: Recipe) {
        foodLabel.text = data.foodName
        timeLabel.text = String(data.minute) + " min"
        
        if let image = UIImage(named: (foodImageList[data.imageName]?.randomElement())!) {
            foodImage.image = image
        }
    }
    
    func cellUISetup() {
        layer.cornerRadius = 6.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.backgroundColor = UIColor.white.cgColor
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: -1.0, height: 2.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 2.0
        layer.masksToBounds = false
    }
    
}
