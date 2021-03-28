//
//  ViewControllerFactory.swift
//  QuizApplication
//
//  Created by Omran Khoja on 3/27/21.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallBack: @escaping ([String]) -> Void) -> UIViewController
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}

