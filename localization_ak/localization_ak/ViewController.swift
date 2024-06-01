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
    
    titleLabel.text = L10n.welcomeTitle
    
    subTitleLabel.text = L10n.loginButton
  }


}

