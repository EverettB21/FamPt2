//
//  AddViewController.swift
//  Family Pt2
//
//  Created by Everett Brothers on 10/16/23.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var member: FamMember?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chooseImage: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        if let member = member {
            title = member.name
            loadMember(member)
        } else {
            title = "Add New Member"
        }
        saveButton.layer.cornerRadius = 10
        imageView.layer.cornerRadius = 10
    }
    
    @IBAction func descriptionChanged(_ sender: Any) {
        if descriptionField.text?.isEmpty == false {
            member?.description = descriptionField.text!
        }
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        if nameField.text?.isEmpty == false {
            member?.name = nameField.text!
        }
    }
    
    func loadMember(_ member: FamMember) {
        nameField.text = member.name
        descriptionField.text = member.description
        if let data = member.imageData {
            imageView.image = UIImage(data: data)
        }
    }
    
    @IBAction func chooseTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[.editedImage] as? UIImage else { return }
        imageView.image = img
        picker.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        member = FamMember(name: nameField.text!, description: descriptionField.text!, imageData: imageView.image?.jpegData(compressionQuality: 0.9))
        if let vc = segue.destination as? ViewController {
            vc.member = member
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
