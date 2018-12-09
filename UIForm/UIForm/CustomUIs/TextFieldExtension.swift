//
//  TextFieldExtension.swift
//  UIForm
//
//  Created by Ankit Thakur on 12/8/18.
//  Copyright © 2018 Ankit Thakur. All rights reserved.
//

import Foundation
import UIFloatLabelTextView
import UIFloatLabelTextField

extension UIFloatLabelTextField {
    

    override open func awakeFromNib() {
        
        // Setup Bottom-Border
        var bottomBorder = UIView()
        self.viewWithTag(111)?.removeFromSuperview()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.tag = 111
        bottomBorder.backgroundColor = NavigationTitleColor // Set Border-Color
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomBorder)
        
        if #available(iOS 9.0, *) {
            bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    
}

extension UIFloatLabelTextView{
    override open func awakeFromNib() {
        
        // Setup Bottom-Border
        var bottomBorder = UIView()
        self.viewWithTag(111)?.removeFromSuperview()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.frame = CGRect(x:self.frame.origin.x, y:self.frame.origin.y+self.frame.height-1, width:self.frame.width, height:1)
        
        bottomBorder.tag = 111
        bottomBorder.backgroundColor = NavigationTitleColor // Set Border-Color
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomBorder)
        
        if #available(iOS 9.0, *) {
            bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
        } else {
            // Fallback on earlier versions
        }
        
        
    }
}
