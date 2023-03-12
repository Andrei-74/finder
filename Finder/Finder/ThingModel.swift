//
//  ThingModel.swift
//  Finder
//
//  Created by Андрей Костицин on 06.03.2023.
//

import RealmSwift
//PlaceModel
//struct Place
class Thing: Object {

    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?


    let thingNames = ["Шок", "Бочка", "Bonsai"]


   func saveThings() {

        for thing in thingNames {
            let image = UIImage(named: thing)
            guard let imageData = image?.pngData() else { return }
            let newThing = Thing()

            newThing.name = thing
            newThing.location = "Ufa"
            newThing.type = "rest"
            newThing.imageData = imageData

            StorageManager.saveObject(newThing)
        }

    }
}
