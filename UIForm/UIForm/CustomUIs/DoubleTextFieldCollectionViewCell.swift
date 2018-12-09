//
//  DoubleTextFieldCollectionViewCell.swift
//  UIForm
//
//  Created by Ankit Thakur on 12/8/18.
//  Copyright © 2018 Ankit Thakur. All rights reserved.
//

import Foundation
import UIKit
import UIFloatLabelTextField

class DoubleTextFieldCollectionViewCell: UICollectionViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var leftTextField:UIFloatLabelTextField!
    @IBOutlet var rightTextField:UIFloatLabelTextField!
    var leftPickerView:UIPickerView?
    var rightPickerView:UIPickerView?
    var pickerData:[String] = []
    var leftPickerData:[String] = []
    var rightPickerData:[String] = []
    let currency:[String] = ["IND", "US", "UK"]
    let rate:[String] = ["No Preference", "Fixed Budget", "Hourly Rate"]
    let payment:[String] = ["No Preference", "E-Payment", "Cash"]
    let startDate:[String] = ["Today", "Thursday 6 Dec", "Thursday 7 Dec", "Till 6 months"]
    let jobterm:[String] = ["No Preference", "Same Day Job", "Multi Days Job", "Recurring Job"]
    
    
    func loadText(_ leftTextFieldPlaceholder:String, _ rightTextFieldPlaceholder:String, _ leftPickerType:CellPickerType, _ rightPickerType:CellPickerType) {
        
        print("\(leftTextFieldPlaceholder):\(leftPickerType):\(rightTextFieldPlaceholder):\(rightPickerType)")
        leftTextField.inputView = nil
        rightTextField.inputView = nil
        
        leftTextField.floatLabelActiveColor = placeHolderColor
        leftTextField.floatLabelPassiveColor = placeHolderColor
        rightTextField.floatLabelActiveColor = placeHolderColor
        rightTextField.floatLabelPassiveColor = placeHolderColor
        
        leftTextField.placeholder = leftTextFieldPlaceholder
        rightTextField.placeholder = rightTextFieldPlaceholder
        
        if leftPickerType != .None {
            leftPickerView = UIPickerView()
            leftPickerView?.delegate = self
            leftTextField.inputView = leftPickerView
            switch leftPickerType {
            case .Currency:
                leftPickerData = currency
            case .JobTerm:
                leftPickerData = jobterm
            case .Payment:
                leftPickerData = payment
            case .Rate:
                leftPickerData = rate
            case .None:
                leftPickerData = []
                leftTextField.inputView = nil
            case .Date:
                leftPickerData = []
            }
        }
        
        if rightPickerType != .None {
            rightPickerView = UIPickerView()
            rightPickerView?.delegate = self
            rightTextField.inputView = rightPickerView
            
            switch rightPickerType {
            case .Currency:
                rightPickerData = currency
            case .JobTerm:
                rightPickerData = jobterm
            case .Payment:
                rightPickerData = payment
            case .Rate:
                rightPickerData = rate
            case .None:
                rightPickerData = []
                rightTextField.inputView = nil
            case .Date:
                rightPickerData = []
            }
        }
    }
    
    // MARK: UIPickerView Delegation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === leftPickerView {
            pickerData = leftPickerData
        }
        else if pickerView === rightPickerView {
            pickerData = rightPickerData
        }
        return pickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        leftTextField.text = pickerData[row]
    }
}
