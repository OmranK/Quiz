//
//  Result.swift
//  QuizEngine
//
//  Created by Omran Khoja on 3/19/21.
//

import Foundation

public struct Result<Question:Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}

