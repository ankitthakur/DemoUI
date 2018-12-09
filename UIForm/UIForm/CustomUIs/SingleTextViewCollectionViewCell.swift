//
//  SingleTextViewCollectionViewCell.swift
//  UIForm
//
//  Created by Ankit Thakur on 12/8/18.
//  Copyright © 2018 Ankit Thakur. All rights reserved.
//

import Foundation
import UIKit
import UIFloatLabelTextView

class SingleTextViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet var textView:UIFloatLabelTextView!
    
    func loadText(_ value:String, _ delegateObject:UITextViewDelegate?) {
        textView.delegate = delegateObject
        textView.floatLabelActiveColor = placeHolderColor
        textView.floatLabelPassiveColor = placeHolderColor
        textView.placeholder = value
    }
}
