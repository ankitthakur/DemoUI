//
//  LandingViewController.swift
//  UIForm
//
//  Created by Ankit Thakur on 12/8/18.
//  Copyright © 2018 Ankit Thakur. All rights reserved.
//

import Foundation
import UIKit

class LandingViewController: UIViewController{
    
    override func viewDidLoad() {
        self.view.backgroundColor = NavigationTitleColor
        self.title = "Post"
    }
    @IBAction func newPostAction(_ sender: Any) {
        
        let newPostViewController = self.storyboard?.instantiateViewController(withIdentifier: "newPostViewController")
        self.title = ""
        self.navigationController?.pushViewController(newPostViewController!, animated: true)
    }
    
}
