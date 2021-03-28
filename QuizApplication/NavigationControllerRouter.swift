//
//  NavigationControllerRouter.swift
//  QuizApplication
//
//  Created by Omran Khoja on 3/19/21.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallBack: @escaping (String) -> Void) -> UIViewController
    func resultViewController(for result: Result<Question<String>, String>) -> UIViewController
}

class NavigationControllerRouter: Router {
    typealias Answer = String
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, answerCallBack: @escaping (Answer) -> Void) {
        show(factory.questionViewController(for: question, answerCallBack: answerCallBack))
    }
    
    func routeTo(result: Result<Question<String>, Answer>){
        show(factory.resultViewController(for: result))
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }

    
}
