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
        
        let viewController = ResultsViewController(summary: "You got 1 of 2 correct", answers: [
            PresentableAnswer(question: "Question??Question??Question??Question??Question??Question??", answer: "Yeah!", wrongAnswer: nil),
            PresentableAnswer(question: "Another Question???", answer: "Hell no!", wrongAnswer: "Hell yeah!")
        ])
        
//        let viewController = QuestionViewController(question: "A queston", options: ["Option1", "Option2", "Option3"]) { print ($0) }
//        viewController.tableView.allowsMultipleSelection = true
        
        viewController.loadViewIfNeeded()
        window.rootViewController = viewController
        
        return true
    }

}

