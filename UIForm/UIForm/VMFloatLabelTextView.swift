//
//  VMFloatLabelTextView.swift
//  VMFloatLabel
//
//  Created by Jimmy Jose on 08/12/14.
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit


class VMFloatLabelTextView: UITextView {
    
    var placeholder:String?
    
    var placeholderLabel = UILabel()
    
    var floatingLabel = UILabel()
    
    var floatingLabelYPadding:CGFloat = 0.0
    
    var placeholderYPadding:CGFloat = 0.0
    
    private var startingTextContainerInsetTop:CGFloat = 0.0
    
    var floatingLabelFont:UIFont?
    
    var floatingLabelTextColor = UIColor.gray
    
    var floatingLabelActiveTextColor:UIColor?
    
    var floatingLabelShouldLockToTop:NSInteger = 1
    
    var placeholderTextColor = UIColor.lightGray.withAlphaComponent(0.65)
    
    var animateEvenIfNotFirstResponder:NSInteger = 0
    
    var floatingLabelShowAnimationDuration = 0.3
    
    var floatingLabelHideAnimationDuration = 0.3
    
    
    convenience init() {
        self.init()
        self.commonInit()
    }
    
    convenience init(frame: CGRect) {
        self.init(frame: frame)
        self.commonInit()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder)!
        
        if ((self.placeholder) != nil) {
            let placeholder = self.placeholder
            self.placeholder = placeholder
        }
        commonInit()
    }
    
    
    private func commonInit(){
        
        self.startingTextContainerInsetTop = self.textContainerInset.top
        self.floatingLabelShouldLockToTop = 1
        self.textContainer.lineFragmentPadding = 0
        
        self.placeholderLabel = UILabel(frame: self.frame)
        self.placeholderLabel.font = self.font
        self.placeholderLabel.text = self.placeholder ?? ""
        self.placeholderLabel.numberOfLines = 0
        self.placeholderLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.placeholderLabel.backgroundColor = UIColor.clear
        self.placeholderLabel.textColor = self.placeholderTextColor
        self.insertSubview(self.placeholderLabel, at: 0)
        
        NotificationCenter.default.addObserver(self, selector:#selector(UIView.layoutSubviews), name: NSNotification.Name(rawValue: "UITextViewTextDidChangeNotification"), object: self)
        
        NotificationCenter.default.addObserver(self, selector:#selector(UIView.layoutSubviews), name: NSNotification.Name(rawValue: "UITextViewTextDidBeginEditingNotification"), object: self)
        
        NotificationCenter.default.addObserver(self, selector:#selector(UIView.layoutSubviews), name: NSNotification.Name(rawValue: "UITextViewTextDidEndEditingNotification"), object: self)
        
        
        self.floatingLabel = UILabel()
        self.floatingLabel.alpha = 0.0
        self.floatingLabel.backgroundColor = self.backgroundColor
        self.addSubview(self.floatingLabel)
        self.floatingLabelFont = UIFont.boldSystemFont(ofSize: 12.0)
        self.floatingLabel.font = self.floatingLabelFont
        self.floatingLabel.textColor = self.floatingLabelTextColor
        
        
        self.floatingLabelTextColor = UIColor.gray
        self.floatingLabel.textColor = self.floatingLabelTextColor
        self.floatingLabelActiveTextColor = self.tintColor
        self.animateEvenIfNotFirstResponder = 0
        layoutSubviews()
        
        
        
    }
    
    /*
    override func dealloc() {
    
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "UITextViewTextDidChangeNotification", object: self)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "UITextViewTextDidBeginEditingNotification", object: self)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "UITextViewTextDidEndEditingNotification", object: self)
    
    }*/
    
    
    
    
    func setPlaceholder(placeholder:String)
    {
        self.placeholder = placeholder
        self.placeholderLabel.text = placeholder
        self.floatingLabel.text = placeholder
        
        if (self.floatingLabelShouldLockToTop == 1) {
            self.floatingLabel.frame = CGRect(x:self.floatingLabel.frame.origin.x,
                                              y:self.floatingLabel.frame.origin.y,
                                              width:self.frame.size.width,
                                              height:self.floatingLabel.frame.size.height)
        }
        
        self.setNeedsLayout()
    }
    
    
    
    func setPlaceholder(placeholder:String, floatingTitle:String)
    {
        self.placeholder = placeholder
        self.placeholderLabel.text = placeholder
        self.floatingLabel.text = floatingTitle
        
        self.setNeedsLayout()
    }
    
    func adjustTextContainerInsetTop()
    {
        self.textContainerInset = UIEdgeInsets(top: self.startingTextContainerInsetTop
            + self.floatingLabel.font.lineHeight + self.placeholderYPadding,
                                               left: self.textContainerInset.left,
                                               bottom: self.textContainerInset.bottom,
                                               right:self.textContainerInset.right)
    }
    
    
    func textRect() -> CGRect
    {
        var rect = self.bounds.inset(by: self.contentInset)
        
        
        if (self.textContainer.lineFragmentPadding > 0) {
            rect.origin.x += self.textContainer.lineFragmentPadding
            rect.origin.y += self.textContainerInset.top
        }
        
        return rect.integral
    }
    
    
    func setLabelOriginForTextAlignment()
    {
        var floatingLabelOriginX:CGFloat = self.textRect().origin.x
        var placeholderLabelOriginX:CGFloat = floatingLabelOriginX
        
        if (self.textAlignment == NSTextAlignment.center) {
            floatingLabelOriginX = (self.frame.size.width/2) - (self.floatingLabel.frame.size.width/2)
            placeholderLabelOriginX = (self.frame.size.width/2) - (self.placeholderLabel.frame.size.width/2)
        }
        else if (self.textAlignment == NSTextAlignment.right) {
            floatingLabelOriginX = self.frame.size.width - self.floatingLabel.frame.size.width
            placeholderLabelOriginX = (self.frame.size.width
                - self.placeholderLabel.frame.size.width - self.textContainerInset.right)
        }/*
        else if (self.textAlignment == NSTextAlignment.Natural) {
        
        JVTextDirection baseDirection = [_floatingLabel.text getBaseDirection]
        if (baseDirection == JVTextDirectionRightToLeft) {
        floatingLabelOriginX = self.frame.size.width - _floatingLabel.frame.size.width
        placeholderLabelOriginX = (self.frame.size.width
        - _placeholderLabel.frame.size.width - self.textContainerInset.right)
        }
        }*/
        
        self.floatingLabel.frame = CGRect(x:floatingLabelOriginX, y:self.floatingLabel.frame.origin.y,
                                          width:self.floatingLabel.frame.size.width, height:self.floatingLabel.frame.size.height)
        
        self.placeholderLabel.frame = CGRect(x:placeholderLabelOriginX, y:self.placeholderLabel.frame.origin.y,
                                             width:self.placeholderLabel.frame.size.width, height:self.placeholderLabel.frame.size.height)
    }
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        adjustTextContainerInsetTop()
        
        self.placeholderLabel.sizeToFit()
        self.floatingLabel.sizeToFit()
        
        let textRect = self.textRect()
        
        self.placeholderLabel.alpha = self.text.lengthOfBytes(using: .utf8) > 0 ? 0.0 : 1.0
        self.placeholderLabel.frame = CGRect(x:textRect.origin.x, y:textRect.origin.y,
                                             width:self.placeholderLabel.frame.size.width, height:self.placeholderLabel.frame.size.height)
        
        self.setLabelOriginForTextAlignment()
        
        if ((self.floatingLabelFont) != nil) {
            let font = self.floatingLabelFont
            self.floatingLabel.font = font
        }
        
        let firstResponder:Bool = self.isFirstResponder
        
        let text = self.text!
        
        if(firstResponder && text.lengthOfBytes(using: .utf8) > 0 ){
            
            self.floatingLabel.textColor = self.labelActiveColor()
            
        }else {
            self.floatingLabel.textColor = self.floatingLabelTextColor
        }
        
        
        if (text.lengthOfBytes(using: .utf8) == 0) {
            hideFloatingLabel(animated: firstResponder)
        }
        else {
            
            showFloatingLabel(animated: firstResponder)
        }
    }
    
    
    
    func setFloatingLabelText(text:String){
        
        self.floatingLabel.text = text
        self.setNeedsLayout()
        
    }
    
    
    func labelActiveColor() -> UIColor {
        
        if(self.floatingLabelActiveTextColor != nil){
            
            return self.floatingLabelActiveTextColor!
            
        }else {
            
            
            let window = UIApplication.shared.keyWindow
            if((window) != nil){
                let color = window?.tintColor
                if((color) != nil){
                    return color!
                    
                }
            }
            
            
        }
        
        return UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        
    }
    
    func setFloatingLabelFont(floatingLabelFont:UIFont){
        
        self.floatingLabelFont = floatingLabelFont
        //self.floatingLabel.font = (floatingLabelFont ? floatingLabelFont : UIFont.boldSystemFontOfSize(12.0))
        let placeholder = self.placeholder
        self.placeholder = placeholder
        
    }
    
    func showFloatingLabel(animated:Bool){
        
        if ((animated || self.animateEvenIfNotFirstResponder != 0)
            && (self.floatingLabelShouldLockToTop == 0 || self.floatingLabel.alpha != 1.0)){
            
            UIView.animate(withDuration: self.floatingLabelShowAnimationDuration,
                           delay: 0.0,
                           options: [.beginFromCurrentState, .curveEaseIn],
                           animations: {
                            self.floatingLabel.alpha = 1.0
                            
                            var top:CGFloat = self.floatingLabelYPadding
                            
                            if (self.floatingLabelShouldLockToTop == 1) {
                                top += self.contentOffset.y
                            }
                            self.floatingLabel.frame = CGRect(x:self.floatingLabel.frame.origin.x,
                                                              y:top,
                                                              width:self.floatingLabel.frame.size.width,
                                                              height:self.floatingLabel.frame.size.height)
            }, completion: nil)
        }else {
            
            self.floatingLabel.alpha = 1.0
            
            var top:CGFloat = self.floatingLabelYPadding
            
            if (self.floatingLabelShouldLockToTop == 1) {
                top += self.contentOffset.y
            }
            self.floatingLabel.frame = CGRect(x:self.floatingLabel.frame.origin.x,
                                              y:top,
                                              width:self.floatingLabel.frame.size.width,
                                              height:self.floatingLabel.frame.size.height);
        }
        
    }
    
    
    func hideFloatingLabel(animated:Bool){
        
        if (animated || self.animateEvenIfNotFirstResponder != 0){
            
            UIView.animate(withDuration: self.floatingLabelHideAnimationDuration,
                           delay: 0.0,
                           options: [.beginFromCurrentState, .curveEaseIn],
                           animations: { () -> Void in
                
                self.floatingLabel.alpha = 0.0
                            self.floatingLabel.frame = CGRect(x:self.floatingLabel.frame.origin.x,
                                                              y:self.floatingLabel.font.lineHeight + self.placeholderYPadding,
                                                              width:self.floatingLabel.frame.size.width,
                                                              height:self.floatingLabel.frame.size.height);
                
                
                
                }, completion: nil)
            
        }else {
            
            self.floatingLabel.alpha = 0.0
            self.floatingLabel.frame = CGRect(x:self.floatingLabel.frame.origin.x, y:self.floatingLabel.font.lineHeight + self.floatingLabelYPadding, width:self.floatingLabel.frame.width, height:self.floatingLabel.frame.height)
            
        }
        
    }
    
    
    func setFont(font:UIFont)
    {
        
        self.placeholderLabel.font = self.font;
        self.layoutSubviews()
    }
    
    func setText(text:NSString)
    {
        
        self.layoutSubviews()
    }
    
    func setPlaceholderTextColor(placeholderTextColor:UIColor)
    {
        self.placeholderTextColor = placeholderTextColor
        self.placeholderLabel.textColor = self.placeholderTextColor
    }
    
    func setBackgroundColor(backgroundColor:UIColor)
    {
        if (self.floatingLabelShouldLockToTop == 1) {
            self.floatingLabel.backgroundColor = self.backgroundColor;
        }
    }
    
    func setTextAlignment(textAlignment:NSTextAlignment){
        
        super.textAlignment = textAlignment
        self.setNeedsLayout()
        
    }
    
    
    
    
}
