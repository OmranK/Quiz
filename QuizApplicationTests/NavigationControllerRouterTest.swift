//
//  NavigationControllerRouterTest.swift
//  QuizApplicationTests
//
//  Created by Omran Khoja on 3/19/21.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApplication

class NavigationControllerRouterTest: XCTestCase {
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()
    
    func test_routeToQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)
        
        sut.routeTo(question: "Q1", answerCallBack: { _ in})
        sut.routeTo(question: "Q2", answerCallBack: { _ in})
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_presentsQuestionControllerWithRightCallback() {
        var callBackWasFired = false
        sut.routeTo(question: "Q1", answerCallBack: { _ in callBackWasFired = true})
        factory.answerCallback["Q1"]!("anything")
        
        XCTAssertTrue(callBackWasFired)
    }
}

class NonAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}

class ViewControllerFactoryStub: ViewControllerFactory {
    private var stubbedQuestions = [String: UIViewController]()
    var answerCallback = [String: (String) -> Void]()
    
    func stub(question: String, with viewController: UIViewController) {
        stubbedQuestions[question] = viewController
    }
    
    func questionViewController(for question: String, answerCallBack: @escaping (String) -> Void) -> UIViewController {
        self.answerCallback[question] = answerCallBack
        return stubbedQuestions[question] ?? UIViewController()
    }
}
