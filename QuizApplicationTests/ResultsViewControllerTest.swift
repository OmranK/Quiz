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
        XCTAssertEqual(makeSut(answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_configuresCell() {
        let sut = makeSut(answers: [makeAnswer(answer: "A1", question: "Q1", isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.answerLabel.text, "A1")
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withIncorrectAnswer_renderWrongAnswerCell() {
        let sut = makeSut(answers: [makeAnswer(isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withIncorrectAnswer_configuresWrongAnswerCell() {
        let sut = makeSut(answers: [makeAnswer(answer: "A1", question: "Q1", isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
    }
    
    
    // MARK: - Helper Methods
    
    func makeSut(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        let _ = sut.view
        return sut
    }
    
    func makeDummyAnswer() -> PresentableAnswer {
        return makeAnswer(isCorrect: false)
    }
    
    func makeAnswer(answer: String = "", question: String = "", isCorrect: Bool) -> PresentableAnswer {
        return PresentableAnswer(answer: answer, question: question, isCorrect: isCorrect)
    }
}

