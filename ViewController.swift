//
//  ViewController.swift
//  MagicTrick - CoinTricks
//
//  Created by quinn hoekstra on 10-03-17.
//  Copyright © 2017 quinn hoekstra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var PlayingCard: UIImageView!
    
    @IBAction func MaskAction(_ sender: Any) {
        PlayingCard.image = maskImage(image: #imageLiteral(resourceName: "red card"), mask: #imageLiteral(resourceName: "card mask"))
        print("working")
    }

     func maskImage(image: UIImage, mask: UIImage )->UIImage {
        
        let imageReference = (image.cgImage)!
        let maskReference = (mask.cgImage)!
        
        let imageMask = CGImage.init(
            maskWidth: maskReference.width
            ,height: maskReference.height
            ,bitsPerComponent: maskReference.bitsPerComponent
            ,bitsPerPixel: maskReference.bitsPerPixel
            ,bytesPerRow: maskReference.bytesPerRow
            ,provider: maskReference.dataProvider!
            ,decode: nil
            ,shouldInterpolate: true
        )
        
        return (UIImage(cgImage:(imageReference.masking(maskReference))!))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    @IBAction func StartTrick(_ sender: Any) {
        self.performSegue(withIdentifier: "showView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showView"
        {
            var vc = segue.destination as! UIViewController
            var controller = vc.popoverPresentationController
            vc.preferredContentSize = CGSize(width: 250, height: 200)
            
            if controller != nil
            {
                controller?.delegate = self
        }
        }
    }

    @IBOutlet weak var iPhoneBackground: UIImageView!

    @IBAction func UploadBackgroundImage(_ sender: Any) {
        let BackgroundImage = UIImagePickerController()
        BackgroundImage.delegate = self
        
        BackgroundImage.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        BackgroundImage.allowsEditing = false
        
        self.present(BackgroundImage, animated: true)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
      {
        if let BackgroundImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            iPhoneBackground.image = BackgroundImage
            self.dismiss(animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
       // BackgroundImage.layer.cornerRadius = BackgroundImage.frame.size.width/5
       // BackgroundImage.clipsToBounds = true
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
   
