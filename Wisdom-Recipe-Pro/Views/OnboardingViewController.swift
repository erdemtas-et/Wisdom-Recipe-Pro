//
//  MainViewController.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 29.03.2023.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {

    // MARK: - UI Elements
    
    @IBOutlet var mainAnimationView: LottieAnimationView!
    
    // MARK: - Properties
   
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeViewController") as? RecipeViewController  else {return}
            self.present(destinationVC, animated: true)
      }
    }
    
    
    // MARK: - Functions
    
    
    
    
    // MARK: - Actions

}

extension OnboardingViewController  {
    
    private func setupAnimation() {
        mainAnimationView!.frame = view.bounds
        mainAnimationView!.contentMode = .scaleAspectFit
        mainAnimationView!.loopMode = .loop
        mainAnimationView!.animationSpeed = 0.5
        mainAnimationView!.play()
    }

}
