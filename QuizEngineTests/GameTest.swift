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
    
    func test_startGame_answerOneOutOfTwoCorrectly_scores1() {
        let router = FakeRouter()
        startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2" : "A2"])
        
        router.answerCallBack("A1")
        router.answerCallBack("Wrong Answer")
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
}
