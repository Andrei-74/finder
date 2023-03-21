//
//  ThingModel.swift
//  Finder
//
//  Created by Андрей Костицин on 06.03.2023.
//

import RealmSwift

class Thing: Object {

    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()

    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
