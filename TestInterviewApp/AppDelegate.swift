//
//  AppDelegate.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 22.12.2020.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    internal var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

