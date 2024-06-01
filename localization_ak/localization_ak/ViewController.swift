//
//  ViewController.swift
//  localization_ak
//
//  Created by Akanksha Thakur on 1/6/24.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var subTitleLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel.text = "welcome_title".localised() // <-------------   Hardcoded localisation
    
    subTitleLabel.text = String(localized: "login_button")
  }


}

