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
    //    let modalView = UIView(frame: UIScreen.main.bounds)
      //  modalView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        //  view.addSubview(modalView)
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce
        animationView!.animationSpeed = 1.0
         view.addSubview(animationView!)
         animationView!.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}


extension Date {
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: self)
    }
}


extension UIViewController {
    func showAlert(alertTitle: String,alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func hideKeyboard() {
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                tap.cancelsTouchesInView = false
                view.addGestureRecognizer(tap)
            }
            
            @objc func dismissKeyboard() {
                view.endEditing(true)
            }
    
}
