//
//  QuestionTest.swift
//  QuizApplicationTests
//
//  Created by Omran Khoja on 3/28/21.
//

import Foundation
import XCTest
@testable import QuizApplication

class QuestionModelTest: XCTestCase {
    
    func test_hashValue_singleAnswer_returnsTypeHash() {
        let type = "a string"
        let sut = Question.singleAnswer(type)
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_hashValue_multipleAnswer_returnsTypeHash() {
        let type = "a string"
        let sut = Question.multipleAnswer(type)
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_equalQuestions_areEqual() {
        XCTAssertEqual(Question.singleAnswer("a string"), Question.singleAnswer("a string"))
        XCTAssertEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("a string"))
    }
    
    func test_notEqualQuestions_areNotEqual() {
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
        XCTAssertNotEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("another string"))
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.multipleAnswer("a string"))
        XCTAssertNotEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("another string"))
    }
    
}
