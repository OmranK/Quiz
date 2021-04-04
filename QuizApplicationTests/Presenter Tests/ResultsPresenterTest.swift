//
//  ResultsPresenterTest.swift
//  QuizApplicationTests
//
//  Created by Omran Khoja on 3/28/21.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApplication

class ResultPresenterTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    func test_title_returnsFormattedTitle() {
        let result: Result<Question<String>, [String]> = Result.make()
        let sut = ResultsPresenter(questions: [], result: result, correctAnswers: [:])
        XCTAssertEqual(sut.title, "Result")
    }
    
    func test_summary_withTwouestionsAndScoreOne_returnsSummary() {
        let answers = [singleAnswerQuestion : ["A1"], multipleAnswerQuestion : ["A2", "A3"]]
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = Result.make(answers: answers, score: 1)
        let sut = ResultsPresenter(questions: orderedQuestions, result: result, correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestions_shouldBeEmpty() {
        let sut = ResultsPresenter(questions: [], result: .make(), correctAnswers: [:] )
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = [singleAnswerQuestion : ["A1"]]
        let correctAnswers = [singleAnswerQuestion : ["A2"]]
        let result = Result.make(answers: answers)
        let sut = ResultsPresenter(questions: [singleAnswerQuestion], result: result, correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswers_mapsAnswers() {
        let answers = [multipleAnswerQuestion : ["A1", "A4"]]
        let correctAnswers = [multipleAnswerQuestion : ["A2", "A3"]]
        let result = Result.make(answers: answers)
        let sut = ResultsPresenter(questions: [multipleAnswerQuestion], result: result, correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswers() {
        let answers = [singleAnswerQuestion: ["A4"], multipleAnswerQuestion : ["A1", "A4"],]
        let correctAnswers = [singleAnswerQuestion : ["A4"], multipleAnswerQuestion : ["A1", "A4"]]
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = Result.make(answers: answers)
        let sut = ResultsPresenter(questions: orderedQuestions, result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A4")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.last!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.last!.wrongAnswer)


    }
}
