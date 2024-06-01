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
    let locale = Locale.preferredLanguages.first
    let preferredLanguage = UserDefaults.standard.string(forKey: "AppPreferredLanguage")
    
    titleLabel.text = "welcome_title".localised() + "\(locale!) " + "  \(preferredLanguage!)" + "\(LocalizationManager.shared.currentLanguage)"
    
    subTitleLabel.text = LocalizationManager.shared.localizedString(forKey: "login_button")
  }


}

