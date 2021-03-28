//
//  iOSViewControllerFactory.swift
//  QuizApplicationTests
//
//  Created by Omran Khoja on 3/28/21.
//

import Foundation
import XCTest
import UIKit
@testable import QuizApplication

class iOSViewControllerFactoryTest: XCTestCase {
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionViewController(question: Question.singleAnswer("Q1")).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionViewController().options, options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        let controller = makeQuestionViewController()
        _ = controller.view
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionViewController(question: Question.multipleAnswer("Q1")).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionViewController(question: Question.multipleAnswer("Q1")).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithMultipleSlection() {
        let controller = makeQuestionViewController(question: Question.multipleAnswer("Q1"))
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(options: Dictionary<Question<String>, [String]>) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
    private func makeQuestionViewController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        let sut = makeSUT(options: [question: options])
        return sut.questionViewController(for: question, answerCallBack: { _ in}) as! QuestionViewController
    }
}
