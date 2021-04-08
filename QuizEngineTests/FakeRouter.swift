//
//  FakeRouter.swift
//  QuizEngineTests
//
//  Created by Omran Khoja on 3/19/21.
//

import Foundation
import QuizEngine

class FakeRouter: Router {
    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    var answerCallBack: ((String) -> Void) = { _ in }
    
    func routeTo(question: String, answerCallBack: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallBack = answerCallBack
    }
    
    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}

