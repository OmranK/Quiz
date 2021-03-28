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
        factory.stub(question: Question.singleAnswer("Q1"), with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"), with: secondViewController)
        
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallBack: { _ in})
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallBack: { _ in})
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_presentsQuestionControllerWithRightCallback() {
        var callBackWasFired = false
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallBack: { _ in callBackWasFired = true})
        factory.answerCallback[Question.singleAnswer("Q1")]!("anything")
        
        XCTAssertTrue(callBackWasFired)
    }
    
    func test_routeToResult_showsResultController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        
        let result = Result(answers: [Question.singleAnswer("Q1") : "A1"], score: 10)
        let secondResult = Result(answers: [Question.singleAnswer("Q2") : "A2"], score: 20)
        
        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)
        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
}

class NonAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}

class ViewControllerFactoryStub: ViewControllerFactory {
    private var stubbedQuestions = Dictionary<Question<String>, UIViewController>()
    private var stubbedResults = Dictionary<Result<Question<String>, String>, UIViewController>()
    var answerCallback = Dictionary<Question<String>, (String) -> Void>()
    
    func stub(question: Question<String>, with viewController: UIViewController) {
        stubbedQuestions[question] = viewController
    }
    
    func stub(result: Result<Question<String>, String>, with viewController: UIViewController) {
        stubbedResults[result] = viewController
    }
    
    func questionViewController(for question: Question<String>, answerCallBack: @escaping (String) -> Void) -> UIViewController {
        self.answerCallback[question] = answerCallBack
        return stubbedQuestions[question] ?? UIViewController()
    }
    
    
    func resultViewController(for result: Result<Question<String>, String>) -> UIViewController {
        return stubbedResults[result] ?? UIViewController()
    }
}

@testable import QuizEngine

extension Result: Hashable {
    
    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> Result<Question, Answer> {
        return Result(answers: answers, score: score)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(score)
    }
    public static func == (lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
