//
//  NavigationControllerRouter.swift
//  QuizApplication
//
//  Created by Omran Khoja on 3/19/21.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: String, answerCallBack: @escaping (String) -> Void) -> UIViewController
//    func resultViewController(for question: Result<Question<String>, String>) -> UIViewController
}

class NavigationControllerRouter: Router {
    typealias Answer = String
    typealias Question = String
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question, answerCallBack: @escaping (Answer) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallBack: answerCallBack)
        navigationController.pushViewController(viewController, animated: true)
    }
    func routeTo(result: Result<Question, Answer>){
//        let viewController = factory.result
    }

    
}
