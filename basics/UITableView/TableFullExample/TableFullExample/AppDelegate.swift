//
//  AppDelegate.swift
//  TableFullExample
//
//  Created by Rasmusson, Jonathan on 2021-06-30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground

        let vc = ViewController()

        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController

        return true
    }

}

