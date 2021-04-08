//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Omran Khoja on 3/19/21.
//

import Foundation
import XCTest
import QuizEngine

class GameTest: XCTestCase {
    
    let router = FakeRouter()
    var game: Game<String, String, FakeRouter>!
    
    override func setUp() {
        super.setUp()
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2" : "A2"])
    }
    
    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        router.answerCallBack("Wrong Answer")
        router.answerCallBack("Wrong Answer")
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        router.answerCallBack("A1")
        router.answerCallBack("Wrong Answer")
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutOfTwoCorrectly_scoresTwo() {
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
}
