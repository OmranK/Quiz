//
//  QuestionPresenterTest.swift
//  QuizApplicationTests
//
//  Created by Omran Khoja on 3/28/21.
//

import Foundation
import XCTest
@testable import QuizApplication

class QuestionPresenterTest: XCTestCase {
    
    let question1 = Question.singleAnswer("A1")
    let question2 = Question.multipleAnswer("A2")
    
    func test_title_forFirstQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question1)
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question2)
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forNonExistantQuestion_noTitle() {
        let sut = QuestionPresenter(questions: [], question: Question.multipleAnswer("A1"))

        XCTAssertEqual(sut.title, "")
    }
}
