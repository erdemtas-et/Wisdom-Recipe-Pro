//
//  RecipeDetailsViewController.swift
//  Wisdom-Recipe-Pro
//
//  Created by Erdem Tas on 30.03.2023.
//

import UIKit
import WebKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    var urlString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let urlString = urlString {
            guard let url = URL(string: urlString) else {return}
            webView.load(URLRequest(url:url))
        }
    }
}
