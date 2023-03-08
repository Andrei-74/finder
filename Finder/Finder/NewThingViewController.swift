//
//  NewThingViewController.swift
//  Finder
//
//  Created by Андрей Костицин on 08.03.2023.
//

import UIKit

class NewThingViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
// MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {

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
