//
//  RecipeModel.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 30.03.2023.
//

import UIKit

struct Recipe : Codable,Equatable {
    let foodName : String
    let webUrl : String
    let minute : String
    var isFavourite : Bool = false
    let imageName : String
}




