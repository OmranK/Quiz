//
//  Game.swift
//  QuizEngine
//
//  Created by Omran Khoja on 3/19/21.
//

import Foundation

public class Game <Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}


public func startGame<Question, Answer, R: Router>(questions: [Question], router: R, correctAnswers:[Question: Answer]) ->
    Game<Question, Answer, R> where R.Answer == Answer, R.Question == Question {
        let flow = Flow(questions: questions, router: router, scoring: { scoring($0, correctAnswers: correctAnswers) })
        flow.start()
        return Game(flow: flow)
}

private func scoring<Question, Answer: Equatable>(_ answers: [Question: Answer], correctAnswers: [Question: Answer]) -> Int {
//    return answers.reduce(0) {(score, tuple) in
//        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
//    }
    return answers.reduce(0) { return $0 + (correctAnswers[$1.key] == $1.value ? 1 : 0) }
}
