//
//  SingleTextFieldCollectionViewCell.swift
//  UIForm
//
//  Created by Ankit Thakur on 12/8/18.
//  Copyright © 2018 Ankit Thakur. All rights reserved.
//

import Foundation
import UIKit
import UIFloatLabelTextField

class SingleTextFieldCollectionViewCell: UICollectionViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var textField:UIFloatLabelTextField!
    var pickerData:[String] = ["one", "two", "three", "seven", "fifteen"]
    var cellPickerView:UIPickerView?
    
    func loadText(_ value:String, _ placeHolderImage:CellPlaceHolderImage, _ pickerType:CellPickerType) {
        textField.placeholder = value
        print("pickerType: \(pickerType)")
        if pickerType != .None {
            cellPickerView = UIPickerView()
            cellPickerView?.delegate = self
            textField.inputView = cellPickerView
        }
    }
    
    // MARK: UIPickerView Delegation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = pickerData[row]
    }
}
