//
//  ResultsPresenter.swift
//  QuizApplication
//
//  Created by Omran Khoja on 3/28/21.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    let questions: [Question<String>]
    let result: Result<Question<String>, [String]>
    let correctAnswers: Dictionary<Question<String>, [String]>
    
    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return questions.map { (question) in
            guard let correctResponse = correctAnswers[question], let userAnswers = result.answers[question] else {
                fatalError("Couldn't find correct answer for question: \(question)")
            }
            return presentableAnswer(question, userAnswers, correctResponse)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswers: [String], _ correctResponse: [String]) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(correctResponse),
                wrongAnswer: formattedWrongAnswer(userAnswers, correctResponse))
        }
    }
    
    private func formattedAnswer(_ correctResponse: [String]) -> String {
        return correctResponse.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(_ userAnswers:[String], _ correctResponse: [String]) -> String? {
        for answer in userAnswers {
            guard correctResponse.contains(answer) else { return formattedAnswer(userAnswers) }
        }
        return nil
    }
}
