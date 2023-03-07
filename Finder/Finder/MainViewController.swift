//
//  MainViewController.swift
//  Finder
//
//  Created by Андрей Костицин on 04.03.2023.
//

import UIKit

class MainViewController: UITableViewController {

    

    //let placed
    let things = Thing.getThings()
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.nameLabel.text = things[indexPath.row].name
        cell.locationLabel.text = things[indexPath.row].location
        cell.typeLabel.text = things[indexPath.row].type
        cell.imageOfThing.image = UIImage(named: things[indexPath.row].image)
        cell.imageOfThing.layer.cornerRadius = cell.imageOfThing.frame.size.height / 2
        cell.imageOfThing.clipsToBounds = true
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {}
}
