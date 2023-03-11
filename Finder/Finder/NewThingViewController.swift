//
//  NewThingViewController.swift
//  Finder
//
//  Created by Андрей Костицин on 08.03.2023.
//

import UIKit

class NewThingViewController: UITableViewController {
    @IBOutlet var ImageThing: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()


    }
// MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)

            }
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)

            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)

            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)

            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }

}

// MARK: Text field delegate

extension NewThingViewController: UITextFieldDelegate {
    //скрываем клавиатуру при нажатию на DONE

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        ImageThing.image = info[.editedImage] as? UIImage
        ImageThing.contentMode = .scaleAspectFill
        ImageThing.clipsToBounds = true
        dismiss(animated: true)
    }
}
