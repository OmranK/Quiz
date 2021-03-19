//
//  Game.swift
//  QuizEngine
//
//  Created by Omran Khoja on 3/19/21.
//

import Foundation

public func startGame<Question, Answer, R: Router>(questions: [Question],
             router: R, correctAnswers:[Question: Answer]) where R.Answer == Answer, R.Question == Question {
    
}
