//
//  QuestionViewControllerTest.swift
//  QuizApplicationTests
//
//  Created by Omran Khoja on 3/17/21.
//

import Foundation
import XCTest
@testable import QuizApplication

class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptions() {
        let sut = makeSUT(options: [])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_oneOption_rendersOneOption() {
        let sut = makeSUT(options: ["A1"])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_rendersOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A2"]).tableView.title(at: 0), "A2")
    }
    
    func test_optionSelected_notifiesDelegate() {
        var receivedAnswer = ""
        let sut = makeSUT(options: ["A1"]) {
            receivedAnswer = $0
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
        
        
        XCTAssertEqual(receivedAnswer, "A1")
    }
    
    // MARK: Helper
    
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: @escaping (String) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
}

private extension UITableView {
    
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
}
