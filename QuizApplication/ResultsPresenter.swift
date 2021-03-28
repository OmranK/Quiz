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
            guard let correctAnswer = correctAnswers[question], let userAnswer = result.answers[question] else {
                fatalError("Couldn't find correct answer for question: \(question)")
            }
            return presentableAnswer(question, userAnswer, correctAnswer)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(correctAnswer),
                wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer))
        }
    }
    
    private func formattedAnswer(_ correctAnswer: [String]) -> String {
        return correctAnswer.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(_ userAnswer:[String], _ correctAnswer: [String]) -> String? {
        return userAnswer == correctAnswer ? nil : formattedAnswer(userAnswer)
    }
}
