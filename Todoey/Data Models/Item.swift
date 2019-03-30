//
//  Item.swift
//  Todoey
//
//  Created by Kappa on 2019/3/29.
//  Copyright © 2019 Qi Liu. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    // change of dynamic properties can be monitored during runtime
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
