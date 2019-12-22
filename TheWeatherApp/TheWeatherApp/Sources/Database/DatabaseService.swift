//
//  Database.swift
//  TheWeatherApp
//
//  Created by ilya on 19/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseService {
    static var database: DatabaseService = DatabaseService()
    let realm: Realm
    private static var documentDirectoryURL: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }()
    
    private init() {
        let fileURL = DatabaseService.documentDirectoryURL.appendingPathComponent("database", isDirectory: false)
        let configuration = Realm.Configuration(fileURL: fileURL, schemaVersion: 3)
        realm = try! Realm(configuration: configuration)
    }
    
    func add<T: Object>(objects: [T]) {
        try! self.realm.write({
            realm.add(objects, update: .all)
        })
    }
    
    func read<T: Object> (filter: String? = nil) -> [T] {
        guard let filter = filter else { return Array(self.realm.objects(T.self).map({ $0 })) }
        let objects = self.realm.objects(T.self).filter(filter)
        return Array(objects.map({ $0 }))
    }
    
    func clearData() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
