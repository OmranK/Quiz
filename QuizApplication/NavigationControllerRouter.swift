//
//  NavigationControllerRouter.swift
//  QuizApplication
//
//  Created by Omran Khoja on 3/19/21.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, answerCallBack: @escaping ([String]) -> Void) {
        show(factory.questionViewController(for: question, answerCallBack: answerCallBack))
    }
    
    func routeTo(result: Result<Question<String>, [String]>){
        show(factory.resultViewController(for: result))
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }

    
}
