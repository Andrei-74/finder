//
//  MainViewController.swift
//  Finder
//
//  Created by Андрей Костицин on 04.03.2023.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!

    //let placed
    var things: Results<Thing>!

    override func viewDidLoad() {
        super.viewDidLoad()

        things = realm.objects(Thing.self)
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.isEmpty ? 0 : things.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let thing = things[indexPath.row]

        cell.nameLabel.text = thing.name
        cell.locationLabel.text = thing.location
        cell.typeLabel.text = thing.type
        cell.imageOfThing.image = UIImage(data: thing.imageData!)



        cell.imageOfThing.layer.cornerRadius = cell.imageOfThing.frame.size.height / 2
        cell.imageOfThing.clipsToBounds = true
        return cell
    }

    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let thing = things[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StorageManager.deleteObject(thing)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }


     //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let thing = things[indexPath.row]
            let newThingVC = segue.destination as! NewThingViewController
            newThingVC.currentThing = thing
        }
    }

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {

        guard let newThingVC = segue.source as? NewThingViewController else { return }
        newThingVC.saveThing()

        tableView.reloadData()

    }
}
