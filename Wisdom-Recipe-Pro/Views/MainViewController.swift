//
//  MainViewController.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 29.03.2023.
//

import UIKit
import Lottie

class MainViewController: UIViewController {

    // MARK: - UI Elements
    
    @IBOutlet var mainAnimationView: LottieAnimationView!
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configUI()
    }
    
    
    // MARK: - Functions
    
    
    
    
    // MARK: - Actions

    @IBAction func getStartedPressed(_ sender: UIButton) {
        let resultVC = storyboard?.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
        navigationController?.pushViewController(resultVC, animated: true)
    }
    

}

extension MainViewController  {
    
    private func configUI() {
        mainAnimationView!.frame = view.bounds
        mainAnimationView!.contentMode = .scaleAspectFit
        mainAnimationView!.loopMode = .loop
        mainAnimationView!.animationSpeed = 0.5
        mainAnimationView!.play()
    }

}
