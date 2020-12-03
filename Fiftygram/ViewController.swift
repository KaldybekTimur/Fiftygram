//
//  ViewController.swift
//  Fiftygram
//
//  Created by Timur on 12/3/20.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    let context = CIContext()
    var original: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
    // Delegate is a way of one class to delegate behavior to some other class
             let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            original = image
        }
    }

    @IBAction func sepiaButtonPressed(_ sender: Any) {
        if original == nil{return}
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter!)
    }
    
    @IBAction func applyNoir(_ sender: Any) {
        if original == nil{return}
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter!)
    }
    
    @IBAction func applyVintage(_ sender: Any) {
        if original == nil{return}
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter!)
    }
    
    func display(_ filter: CIFilter){
        filter.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
        if let output = filter.outputImage{
            imageView.image = UIImage(cgImage: self.context.createCGImage(output, from: output.extent)!)
        }
    }
}

