//
//  ThingModel.swift
//  Finder
//
//  Created by Андрей Костицин on 06.03.2023.
//

import Foundation
//PlaceModel
//struct Place
struct Thing {

    var name: String
    var location: String
    var type: String
    var image: String
    //restaurantNames = thingNames
    static let thingNames = ["Шок", "Бочка", "Bonsai"]

    //func getPlaces
    static func getThings() -> [Thing] {
        var things = [Thing]()
        for thing in thingNames {
            things.append(Thing(name: thing, location: "Уфа", type: "Рест", image: thing))
        }
        return things
    }
}
