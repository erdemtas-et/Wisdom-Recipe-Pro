//
//  Extensions.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 30.03.2023.
//

import UIKit
import Lottie


extension AddRecipeViewController {
    func showConfirm() {
        var animationView: LottieAnimationView?
        animationView = .init(name: "94433-green-success-confirmation")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce
        animationView!.animationSpeed = 0.5
         view.addSubview(animationView!)
         animationView!.play()
        navigationController?.popViewController(animated: true)
    }
}


extension Date {
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: self)
    }
}
