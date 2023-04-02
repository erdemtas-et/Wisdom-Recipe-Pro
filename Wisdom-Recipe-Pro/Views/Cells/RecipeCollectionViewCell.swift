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
    @IBOutlet var favouriteImage: UIImageView!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
        layer.cornerRadius = 6.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.white.cgColor
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2.0)//CGSizeMake(0, 2.0);
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 2.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect:layer.bounds, cornerRadius:layer.cornerRadius).cgPath
            
        }

    func setup(data: Recipe) {
        foodLabel.text = data.foodName
        timeLabel.text = String(data.minute) + " min"
        foodImage.image = data.image
        favouriteImage.image = data.isFavourite ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
       
    }
    
}
