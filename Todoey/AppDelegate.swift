//
//  AppDelegate.swift
//  Todoey
//
//  Created by Kappa on 2019/3/22.
//  Copyright © 2019 Qi Liu. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // initiate realm to catch any error
        do {
            _ = try Realm()
        } catch {
            print("Error initializing new realm \(error)")
        }
        
        return true
    }
}
