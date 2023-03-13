//
//  StorageManager.swift
//  Finder
//
//  Created by Андрей Костицин on 13.03.2023.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ thing: Thing) {
        try! realm.write {
            realm.add(thing)
        }
    }
    static func deleteObject(_ thing: Thing) {
        try! realm.write {
            realm.delete(thing)
        }
    }
}
