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
    
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()
    
    func test_routeToQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        factory.stub(question: multipleAnswerQuestion, with: secondViewController)
        
        sut.routeTo(question: singleAnswerQuestion, answerCallBack: { _ in})
        sut.routeTo(question: multipleAnswerQuestion, answerCallBack: { _ in})
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {
        var callBackWasFired = false
        sut.routeTo(question: singleAnswerQuestion, answerCallBack: { _ in callBackWasFired = true})
        factory.answerCallback[singleAnswerQuestion]!(["anything"])
        XCTAssertTrue(callBackWasFired)
    }
    
    
    func test_routeToQuestion_singleAnswer_doesNotConfigureViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        sut.routeTo(question: singleAnswerQuestion, answerCallBack: { _ in })
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToQuestion_multipleAnswer_answerCallback_doesNotProgressToNextQuestion() {
        var callBackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallBack: { _ in callBackWasFired = true})
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertFalse(callBackWasFired)
    }
    
    func test_routeToQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        sut.routeTo(question: multipleAnswerQuestion, answerCallBack: { _ in })
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routeToQuestion_multipleAnswer_progressesToNextQuestion() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        var callBackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallBack: { _ in callBackWasFired = true })
        
        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        viewController.navigationItem.rightBarButtonItem?.simulateTap()
        XCTAssertTrue(callBackWasFired)
    }
    
    func test_routeToQuestion_multipleAnswerSubmitButton_isDisabledWhenZeroAnswersSelected() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        sut.routeTo(question: multipleAnswerQuestion, answerCallBack: { _ in })
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToResult_showsResultController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        
        let result = Result.make(answers: [singleAnswerQuestion : ["A1"]], score: 10)
        let secondResult = Result.make(answers: [multipleAnswerQuestion : ["A2"]], score: 20)
        
        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)
        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
}

// MARK: - Helpers

class NonAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}

class ViewControllerFactoryStub: ViewControllerFactory {
    private var stubbedQuestions = Dictionary<Question<String>, UIViewController>()
    private var stubbedResults = Dictionary<Result<Question<String>, [String]>, UIViewController>()
    var answerCallback = Dictionary<Question<String>, ([String]) -> Void>()
    
    func stub(question: Question<String>, with viewController: UIViewController) {
        stubbedQuestions[question] = viewController
    }
    
    func stub(result: Result<Question<String>, [String]>, with viewController: UIViewController) {
        stubbedResults[result] = viewController
    }
    
    func questionViewController(for question: Question<String>, answerCallBack: @escaping ([String]) -> Void) -> UIViewController {
        self.answerCallback[question] = answerCallBack
        return stubbedQuestions[question] ?? UIViewController()
    }
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return stubbedResults[result] ?? UIViewController()
    }
}

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
