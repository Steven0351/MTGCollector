//
//  CardViewController.swift
//  MTGCollector
//
//  Created by Steven Sherry on 12/12/16.
//  Copyright © 2016 Affinity for Apps. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var card : Card? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        if card != nil{
            cardImageView.image = UIImage(data: card!.image as! Data)
            titleTextField.text = card!.name
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        cardImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func addTapped(_ sender: Any) {
        
        if card != nil{
            card!.name = titleTextField.text
            card!.image = UIImagePNGRepresentation(cardImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let card = Card(context: context)
            card.name = titleTextField.text
            card.image = UIImagePNGRepresentation(cardImageView.image!) as NSData?
                    }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)

        
    }

    @IBAction func deleteButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(card!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
}
