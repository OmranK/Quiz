//
//  AppDelegate.swift
//  QuizApplication
//
//  Created by Omran Khoja on 3/17/21.
//

import UIKit
import QuizEngine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let question1 = Question.singleAnswer("What is Omran's age?")
        let option1 = "27"
        let option2 = "29"
        let option3 = "25"
        let optionsQ1 = [option1, option2, option3]
        
        
        let question2 = Question.multipleAnswer("What is Omran's nationality?")
        let option4 = "American"
        let option5 = "Canadian"
        let option6 = "Uzbek"
        let option7 = "French"
        let optionsQ2 = [option4, option5, option6, option7]
        
        let questions = [question1, question2]
        let options = [question1: optionsQ1, question2: optionsQ2]
        let correctAnswers = [question1: [option1], question2: [option4, option6]]
        
        let navigationController = UINavigationController()
        let factory = iOSViewControllerFactory(questions: questions, options: options, correctAnswers: correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
        
        return true
    }
}

