//
//  NewPostViewController.swift
//  UIForm
//
//  Created by Ankit Thakur on 12/6/18.
//  Copyright © 2018 Ankit Thakur. All rights reserved.
//

import UIKit
import UIFloatLabelTextField
import UIFloatLabelTextView

enum CellPlaceHolderImage:Int {
    case None = 0
    case Categories = 2
    case Location = 5
}

enum CellPickerType:Int {
    case None = 0
    case Currency = 1
    case Rate = 2
    case Payment = 3
    case Date = 4
    case JobTerm = 5
}

class NewPostViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate, HorizontalStackViewCellDelgate {
    
    @IBOutlet var formCollectionView:UICollectionView!
    let placeholders = ["Enter Post Title", "Describe Your Post", "Select Post Categories", "Budget", "INR", "Rate", "Payment Method", "Set Location", "Start Date", "Job Term"]
    
    var picker:UIPickerView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Post"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell
        
        var index = indexPath.section
        var placeHolderImage = CellPlaceHolderImage.None
        var pickerType = CellPickerType.None
        var rightPickerType = CellPickerType.None
        switch indexPath.section{
        case 2:
            index = 2;
            placeHolderImage = .Categories
        case 3:
            index = 3;
            rightPickerType = .Currency
        case 4:
            index = 5;
            pickerType = .Rate
            rightPickerType = .Payment
        case 5:
            index = 7;
        case 6:
            index = 8;
            pickerType = .Date
            rightPickerType = .JobTerm
        default:
            index = indexPath.section
        }
        
        print("cell picker: \(pickerType)")
        
        
        switch indexPath.section {
        case 0, 2, 5:
            let singleTextFieldCell:SingleTextFieldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleTextFieldCellIdentifier", for: indexPath) as! SingleTextFieldCollectionViewCell
            singleTextFieldCell.loadText(placeholders[index], CellPlaceHolderImage(rawValue: indexPath.section)!, pickerType)
            cell = singleTextFieldCell as UICollectionViewCell
            
        case 1:
            let singleTextViewCell:SingleTextViewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleTextViewCellIdentifier", for: indexPath) as! SingleTextViewCollectionViewCell
            singleTextViewCell.loadText(placeholders[index], self)
            cell = singleTextViewCell as UICollectionViewCell
        case 7:
            let horizontalStackViewCell:HorizontalStackViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"HorizontalStackCollectionViewCellIdentifier", for: indexPath) as! HorizontalStackViewCell
            horizontalStackViewCell.loadData(medias: ["add"], delegate: self)
            
            cell = horizontalStackViewCell
        default:
            let doubleTextViewCell:DoubleTextFieldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoubleTextFieldCellIdentifier", for: indexPath) as! DoubleTextFieldCollectionViewCell
            doubleTextViewCell.loadText(placeholders[index], placeholders[index+1], pickerType, rightPickerType)
            cell=doubleTextViewCell
        }
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize.zero
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleTextViewCellIdentifier", for: indexPath)
            let textView = cell.viewWithTag(10) as? UIFloatLabelTextView
            var newSize = textView?.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
            if Double(newSize?.height ?? 60) < 60.0 {
                newSize?.height = 60
            }
            size = CGSize(width: formCollectionView.frame.size.width - formCollectionView.contentInset.left - formCollectionView.contentInset.right, height: newSize?.height ?? 60)
        case 7:
            size = CGSize(width: formCollectionView.frame.size.width - formCollectionView.contentInset.left - formCollectionView.contentInset.right, height: 140)
        default:
            size = CGSize(width: self.view.frame.size.width - formCollectionView.contentInset.left - formCollectionView.contentInset.right, height: 60)
        }
        return size
    }

    // MARK: UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        
        let size = textView.bounds.size
        var newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            UIView.setAnimationsEnabled(true)
            formCollectionView.performBatchUpdates({
                if Double(newSize.height ) < 60.0 {
                    newSize.height = 60
                }
                let newCellSize = CGSize(width: formCollectionView.frame.size.width - formCollectionView.contentInset.left - formCollectionView.contentInset.right, height: newSize.height )
                
                let cell = formCollectionView.cellForItem(at: IndexPath(row: 0, section: 1))
                var frame = cell?.frame
                frame?.size = newCellSize
                cell?.frame = frame!
            }, completion: nil)
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        formCollectionView.reloadData()
    }
    
    func didSelectMedia(atIndex: Int) {
        print("selected media index:\(atIndex)")
        
        if atIndex == 0 {
            
            // open camera and save media from CameraUtils
            
        }
    }
}

