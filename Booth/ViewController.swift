//
//  ViewController.swift
//  Booth
//
//  Created by Fannie on 5/8/2019.
//  Copyright © 2019 cmbu. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet private weak var previewView: UIImageView!
    private var captueMode = true;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func takePhoto(_ takePhotoButton: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let picker = UIImagePickerController()
            
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        } else {
            
            let alertVc = UIAlertController(title: "提示", message: "相机不可用", preferredStyle: .alert)
            let sureAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertVc.addAction(sureAction)
            
            self.present(alertVc, animated: true, completion: nil)
        }
    }
    
    @IBAction private func viewPhotos(_ viewPhotosButton: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func isFromPhotoLibray(_ info: [UIImagePickerController.InfoKey : Any]) -> Bool {
        return info[UIImagePickerController.InfoKey.phAsset] != nil;
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        previewView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        picker.dismiss(animated: true, completion: nil)

        if let image = previewView?.image, !isFromPhotoLibray(info) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


}

