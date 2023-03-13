//
//  NewThingViewController.swift
//  Finder
//
//  Created by Андрей Костицин on 08.03.2023.
//

import UIKit

class NewThingViewController: UITableViewController {
    var currentThing: Thing?
    var imageIsChanged = false
    @IBOutlet var thingName: UITextField!
    @IBOutlet var thingImage: UIImageView!

    @IBOutlet var thingType: UITextField!
    @IBOutlet var thingLocation: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        thingName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()

    }
// MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {

            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")


            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

            let cancel = UIAlertAction(title: "Cancel", style: .cancel)

            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)

            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }

    func saveThing() {

        var image: UIImage?

        if imageIsChanged {
            image = thingImage.image
        } else {
            image = #imageLiteral(resourceName: "photo")
        }

        let imageData = image?.pngData()
        let newThing = Thing(name: thingName.text!,
                             location: thingLocation.text, type: thingType.text, imageData: imageData)
        if currentThing != nil {
            try! realm.write {
                currentThing?.name = newThing.name
                currentThing?.location = newThing.location
                currentThing?.type = newThing.type
                currentThing?.imageData = newThing.imageData
            }
        } else {
            StorageManager.saveObject(newThing)
        }

    }

    private func setupEditScreen() {
        if currentThing != nil {
            setupNavigationBar()
            imageIsChanged = true
            guard let data = currentThing?.imageData, let image = UIImage(data: data) else { return }
            thingImage.image = image
            thingImage.contentMode = .scaleAspectFill
            thingName.text = currentThing?.name
            thingLocation.text = currentThing?.location
            thingType.text = currentThing?.type
        }
    }

    private  func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentThing?.name
        saveButton.isEnabled = true
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }

}

// MARK: Text field delegate

extension NewThingViewController: UITextFieldDelegate {
    //скрываем клавиатуру при нажатию на DONE

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc private func textFieldChanged() {
        if thingName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

// MARK: Work with image

extension NewThingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        thingImage.image = info[.editedImage] as? UIImage
        thingImage.contentMode = .scaleAspectFill
        thingImage.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}
