//
//  ResultsViewControllerTest.swift
//  QuizApplicationTests
//
//  Created by Omran Khoja on 3/17/21.
//

import Foundation
import XCTest
@testable import QuizApplication

class ResultViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummar() {
        XCTAssertEqual(makeSut(summary: "a summary").headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_rendersAnswer() {
        XCTAssertEqual(makeSut(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSut(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_configuresCell() {
        let answer = makeAnswer(answer: "A1", question: "Q1")
        let sut = makeSut(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.answerLabel.text, "A1")
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withIncorrectAnswer_configuresWrongAnswerCell() {
        let answer = makeAnswer(answer: "A1", question: "Q1", wrongAnswer: "Wrong")
        let sut = makeSut(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "Wrong")
    }
    
    
    // MARK: - Helper Methods
    
    func makeSut(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        let _ = sut.view
        return sut
    }
    
    func makeAnswer(answer: String = "", question: String = "", wrongAnswer: String? = nil) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
}

