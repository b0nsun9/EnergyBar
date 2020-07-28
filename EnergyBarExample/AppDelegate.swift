//
//  AppDelegate.swift
//  EnergyBarExample
//
//  Created by Bonsung Koo on 2020/07/28.
//  Copyright © 2020 Bonsung Koo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        App.energyBar.setDelegate(delegate: self)
        
        return true
    }

}

