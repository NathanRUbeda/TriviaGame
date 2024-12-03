//
//  QuestionViewModel_Tests.swift
//  TriviaGameTests
//
//  Created by Nathan Ubeda on 11/27/24.
//

import XCTest
@testable import TriviaGame

final class QuestionViewModel_Tests: XCTestCase {
	var viewModel: QuestionViewModel?
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		viewModel = QuestionViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		viewModel = nil
    }

	func test_QuestionViewModel_fetchQuestions_shouldReturnQuestions() async throws {
		// Given
		guard let viewModel else {
			XCTFail()
			return
		}
		
		// When
		let limit = 5.0
		let category = Category.generalKnowledge
		let difficulty = Difficulty.easy
		
		let questions = try await viewModel.fetchQuestions(
			limit: limit,
			category: category,
			difficulty: difficulty
		)
		
		// Then
		XCTAssertNotNil(questions)
	}
	
	func test_QuestionViewModel_nextQuestion_shouldResetStats() async throws {
		// Given
		guard let viewModel else {
			XCTFail()
			return
		}
		let webService = MockWebService()
		
		// When
		let response = try await webService.fetchQuestions(
			limit: 5.0,
			category: Category.filmAndTv,
			difficulty: Difficulty.easy
		)
		let currentQuestionIndex = response.questions.startIndex
		let firstQuestion = response.questions[currentQuestionIndex]
		viewModel.currentQuestion = firstQuestion
		
		let selectedAlternative = firstQuestion.correctAnswer
		let timeRemaining = 0
		viewModel.questions = response.questions
		viewModel.selectedAlternative = selectedAlternative
		viewModel.timeRemaining = timeRemaining
		viewModel.currentQuestionIndex = currentQuestionIndex
		
		viewModel.nextQuestion()
		
		// Then
		XCTAssertNil(viewModel.selectedAlternative)
		XCTAssertEqual(viewModel.timeRemaining, 30)
	}
	
	func test_QuestionViewModel_addToScore_shouldAddToScore() async throws {
		// Given
		guard let viewModel else {
			XCTFail()
			return
		}
		let webService = MockWebService()
		
		// When
		let response = try await webService.fetchQuestions(limit: 1.0, category: Category.filmAndTv,difficulty: Difficulty.hard)
		let firstIndex = response.questions.startIndex
		let firstQuestion = response.questions[firstIndex]
		viewModel.currentQuestion = firstQuestion
		
		let selectedAlternative = "Tim Roth"
		viewModel.selectedAlternative = selectedAlternative
		viewModel.addToScore()
		
		// Then
		XCTAssertGreaterThan(viewModel.userScore, 0)
	}
}
