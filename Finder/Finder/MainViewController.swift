//
//  MainViewController.swift
//  Finder
//
//  Created by Андрей Костицин on 04.03.2023.
//

import UIKit

class MainViewController: UITableViewController {

    

    //let placed
    var things = Thing.getThings()
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let thing = things[indexPath.row]

        cell.nameLabel.text = thing.name
        cell.locationLabel.text = thing.location
        cell.typeLabel.text = thing.type

        if thing.image == nil {
            cell.imageOfThing.image = UIImage(named: thing.imageThing!)
        } else {
            cell.imageOfThing.image = thing.image
        }
        
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
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {

        guard let newThingVC = segue.source as? NewThingViewController else { return }
        newThingVC.saveNewThing()
        things.append(newThingVC.newThing!)
        tableView.reloadData()

    }
}
