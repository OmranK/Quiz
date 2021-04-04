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
        switch question {
        case .singleAnswer:
            show(factory.questionViewController(for: question, answerCallBack: answerCallBack))
        case .multipleAnswer:
            let button = UIBarButtonItem(title: "Submit", style: .done, target: .none, action: nil)
            let buttonController = SubmitButtonController(button, answerCallBack)
            let controller = factory.questionViewController(for: question, answerCallBack: { selection in
                buttonController.update(selection)
            })
            controller.navigationItem.rightBarButtonItem = button
            show(controller)
        }
    }
    
    func routeTo(result: Result<Question<String>, [String]>){
        show(factory.resultViewController(for: result))
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callback: ([String]) -> Void
    private var selections: [String] = []
    
    init(_ button: UIBarButtonItem, _ callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        self.setup()
    }
    
    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
        updateButtonState()
    }
    
    func update(_ selections: [String]) {
        self.selections = selections
        updateButtonState()
    }
    
    private func updateButtonState() {
        button.isEnabled = selections.count > 0
    }
    
    @objc private func fireCallback() {
        callback(selections)
    }


}
