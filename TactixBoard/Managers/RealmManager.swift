//
//  RealmManager.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 13/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private init() {}
    
    var defaultRealm: Realm {
        // swiftlint:disable:next force_try
        let realm = try! Realm()
        return realm
    }
}
