//
//  HorizontalStackViewCell.swift
//  UIForm
//
//  Created by Ankit Thakur on 12/8/18.
//  Copyright © 2018 Ankit Thakur. All rights reserved.
//

import Foundation
import UIKit

protocol HorizontalStackViewCellDelgate{
    
    func didSelectMedia(atIndex:Int)
}

class HorizontalStackViewCell: UICollectionViewCell {
    
    @IBOutlet var scrollView:UIScrollView!
    private var scrollContentWidth = 0.0
    private var itemDelegate:HorizontalStackViewCellDelgate?
    
    func loadData(medias:[String], delegate:HorizontalStackViewCellDelgate?){
        
        self.itemDelegate = delegate
        
        for index in 0..<medias.count {
            let thumbWidth = 90
            let thumbSpacing = 10
            let thumbXCoords = Double(index) * (Double(thumbWidth) + Double(thumbSpacing))
            let thumbButton = UIButton(
                frame: CGRect(
                    x: thumbXCoords,
                    y: 0.0,
                    width: Double(thumbWidth),
                    height: Double(thumbWidth)))
            thumbButton.contentMode = .scaleAspectFit
            thumbButton.backgroundColor = UIColor.red
            thumbButton.layer.borderColor = UIColor.blue.cgColor
            thumbButton.layer.borderWidth = 0.25
            thumbButton.tag = index
            thumbButton.addTarget(self, action: #selector(didSelect), for: .touchUpInside)
            scrollContentWidth = scrollContentWidth + Double(thumbWidth)
            scrollView.addSubview(thumbButton)
            scrollView.contentSize = CGSize(
                width: Double(self.scrollContentWidth),
                height: Double(scrollView.frame.size.height))
        }
    }
    
    @objc func didSelect(button:UIButton) {
        self.itemDelegate?.didSelectMedia(atIndex: button.tag)
    }
}
