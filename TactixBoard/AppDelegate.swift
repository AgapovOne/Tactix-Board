//
//  AppDelegate.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 05/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // RUN ONLY ON FIRST TIME
        let hasLaunchedKey = "HasLaunched"
        let defaults = UserDefaults.standard
        let hasLaunched = defaults.bool(forKey: hasLaunchedKey)
        
        if !hasLaunched {
            UserDefaults.standard.setValue("thin", forKey: "currentLineType")
            
            defaults.set(true, forKey: hasLaunchedKey)
        }


        Alert.setup()

        Fabric.with([Crashlytics.self()])

        return true
    }
}
