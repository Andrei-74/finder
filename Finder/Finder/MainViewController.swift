//
//  MainViewController.swift
//  Finder
//
//  Created by Андрей Костицин on 04.03.2023.
//

import UIKit

class MainViewController: UITableViewController {

    //restaurantNames = thingNames
    let thingNames = ["Шок", "Бочка", "Bonsai"]

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thingNames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.nameLabel.text = thingNames[indexPath.row]
        cell.imageOfThing.image = UIImage(named: thingNames[indexPath.row])
        cell.imageOfThing.layer.cornerRadius = cell.imageOfThing.frame.size.height / 2
        cell.imageOfThing.clipsToBounds = true
        return cell
    }

    // MARK: - Table View Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
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
