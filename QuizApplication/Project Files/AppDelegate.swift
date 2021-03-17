//
//  AppDelegate.swift
//  QuizApplication
//
//  Created by Omran Khoja on 3/17/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.makeKeyAndVisible()
        
        let viewController = QuestionViewController(question: "A queston", options: ["Option1", "Option2", "Option3"]) { print ($0) }
        viewController.loadViewIfNeeded()
//        viewController.tableView.allowsMultipleSelection = true
        
        window.rootViewController = viewController
        
        return true
    }

}

