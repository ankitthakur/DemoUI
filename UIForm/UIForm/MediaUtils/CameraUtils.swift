//
//  CameraUtils.swift
//  UIForm
//
//  Created by Ankit Thakur on 12/9/18.
//  Copyright © 2018 Ankit Thakur. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class CameraUtils{
    
    let kMAXDURATION = 120.0
    
    var delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate
    init(delegate_ : UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        delegate = delegate_
    }
    
    func PresentPhotoLibrary(target: UIViewController, canEdit: Bool) {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) && !UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            return
        }
        let type = kUTTypeImage as String
        let imagePicker = UIImagePickerController()
        if imagePicker.sourceType == .photoLibrary {
            imagePicker.sourceType = .photoLibrary
            if let avaliableTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
                if (avaliableTypes.contains(type)){
                    imagePicker.mediaTypes = [type]
                    imagePicker.allowsEditing = canEdit
                }
            }
            else if imagePicker.sourceType == .savedPhotosAlbum{
                imagePicker.sourceType = .savedPhotosAlbum
                if let avaliableTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum){
                    if (avaliableTypes.contains(type)){
                        imagePicker.mediaTypes = [type]
                        imagePicker.allowsEditing = canEdit
                    }
                }
                else{
                    return
                    
                }
            }
            imagePicker.allowsEditing = canEdit
            imagePicker.delegate = delegate
            target.present(imagePicker, animated: true, completion: nil)
            return
        }
    }
    
    func PresentMultiCamera(target: UIViewController, canEdit: Bool) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            return
        }
        let type1 = kUTTypeImage
        let type2 = kUTTypeMovie
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            if let avaliableTypes = UIImagePickerController.availableMediaTypes(for: .camera){
                if (avaliableTypes.contains(type1 as String)){
                    imagePicker.mediaTypes = [type1, type2] as [String]
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                }
            }
            if UIImagePickerController.isCameraDeviceAvailable(.rear){
                imagePicker.cameraDevice = UIImagePickerController.CameraDevice.rear
            }
            if UIImagePickerController.isCameraDeviceAvailable(.front){
                imagePicker.cameraDevice = UIImagePickerController.CameraDevice.front
            }
        }
        else{
            return
        }
        imagePicker.allowsEditing = canEdit
        imagePicker.showsCameraControls = true
        imagePicker.delegate = delegate
        target.present(imagePicker, animated: true, completion: nil) // presents the imagepicker to the user
    }
    
    
    func PresentPhotoCamera(target: UIViewController,  canEdit: Bool) {
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            return
        }
        
        let type1 = kUTTypeImage as String
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .camera) {
                
                if (availableTypes as NSArray).contains(type1) {
                    
                    imagePicker.mediaTypes = [type1]
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                }
            }
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                imagePicker.cameraDevice = UIImagePickerController.CameraDevice.rear
            }
            else if UIImagePickerController.isCameraDeviceAvailable(.front) {
                imagePicker.cameraDevice = UIImagePickerController.CameraDevice.front
            }
        } else {
            //show alert, no camera available
            return
        }
        
        imagePicker.allowsEditing = canEdit
        imagePicker.showsCameraControls = true
        imagePicker.delegate = delegate
        target.present(imagePicker, animated: true, completion: nil) // presents the imagepicker to the user
    }
    
    // Video Camera
    func PresentVideoCamera(target: UIViewController,  canEdit: Bool) {
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            return
        }
        
        let type1 = kUTTypeMovie as String
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .camera) {
                
                if (availableTypes as NSArray).contains(type1) {
                    
                    imagePicker.mediaTypes = [type1]
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.videoMaximumDuration = kMAXDURATION
                }
            }
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                imagePicker.cameraDevice = UIImagePickerController.CameraDevice.rear
            }
            else if UIImagePickerController.isCameraDeviceAvailable(.front) {
                imagePicker.cameraDevice = UIImagePickerController.CameraDevice.front
            }
        } else {
            //show alert, no camera available
            return
        }
        
        imagePicker.allowsEditing = canEdit
        imagePicker.showsCameraControls = true
        imagePicker.delegate = delegate
        target.present(imagePicker, animated: true, completion: nil) // presents the imagepicker to the user
    }
    //video library
    func PresentVideoLibrary(target: UIViewController, canEdit: Bool) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) && !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
            return
        }
        
        let type = kUTTypeMovie as String
        let imagePicker = UIImagePickerController()
        
        imagePicker.videoMaximumDuration = kMAXDURATION
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            imagePicker.sourceType = .photoLibrary
            
            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
                
                if (availableTypes as NSArray).contains(type) {
                    
                    /* Set up defaults */
                    imagePicker.mediaTypes = [type]
                    imagePicker.allowsEditing = canEdit
                }
            }
        } else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.sourceType = .savedPhotosAlbum
            
            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum) {
                
                if (availableTypes as NSArray).contains(type) {
                    imagePicker.mediaTypes = [type]
                }
            }
        } else {
            return
        }
        
        imagePicker.allowsEditing = canEdit
        imagePicker.delegate = delegate
        target.present(imagePicker, animated: true, completion: nil) // presents the imagepicker to the user
        
        return
    }
    
    
}
