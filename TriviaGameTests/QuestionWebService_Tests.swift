//
//  QuestionWebService_Tests.swift
//  TriviaGameTests
//
//  Created by Nathan Ubeda on 11/27/24.
//

import Foundation
import XCTest
@testable import TriviaGame

final class QuestionWebService_Tests: XCTestCase {
	var webService: QuestionProvider?
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		webService = MockWebService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		webService = nil
    }

	func test_WebService_fetchQuestions_shouldFetchRightAmountOfQuestions() async throws {
		// Given
		guard let webService else {
			XCTFail()
			return
		}
		
		// When
		let limit = 1.0
		let category = Category.filmAndTv
		let difficulty = Difficulty.easy
		
		let response = try await webService.fetchQuestions(
			limit: limit,
			category: category,
			difficulty: difficulty
		)
		
		// Then
		XCTAssertEqual(response.questions.count, Int(limit))
	}
	
	func test_WebService_fetchQuestions_shouldFetchSelectedCategory() async throws {
		// Given
		guard let webService else {
			XCTFail()
			return
		}
		
		// When
		let limit = 1.0
		let difficulty = Difficulty.easy
		
		// Then
		for category in Category.allCases {
			let category = category
			
			let response = try await webService.fetchQuestions(
				limit: limit,
				category: category,
				difficulty: difficulty
			)
			let firstIndex = response.questions.startIndex
			let firstQuestion = response.questions[firstIndex]
			
			XCTAssertEqual(firstQuestion.category, category)
		}
	}
	
	func test_WebService_fetchQuestions_shouldFetchSelectedDifficulty() async throws {
		// Given
		guard let webService else {
			XCTFail()
			return
		}
		
		// When
		let limit = 1.0
		let category = Category.filmAndTv
		
		// Then
		for difficulty in Difficulty.allCases {
			let difficulty = difficulty
			
			let response = try await webService.fetchQuestions(
				limit: limit,
				category: category,
				difficulty: difficulty
			)
			let firstIndex = response.questions.startIndex
			let firstQuestion = response.questions[firstIndex]
			
			XCTAssertEqual(firstQuestion.difficulty, difficulty)
		}
	}
}
