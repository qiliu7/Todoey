//
//  Category.swift
//  Todoey
//
//  Created by Kappa on 2019/3/29.
//  Copyright © 2019 Qi Liu. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    
    let items = List<Item>()
}
