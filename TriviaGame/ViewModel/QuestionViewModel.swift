//
//  QuestionViewModel.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/5/24.
//

import Foundation
import SwiftUI

/// An object that is used to model data with home view.
@Observable
class QuestionViewModel: Hashable, Equatable {
	/// Conforms to Equatable protocol.
	static func == (lhs: QuestionViewModel, rhs: QuestionViewModel) -> Bool {
		lhs.questions == rhs.questions
	}
	
	/// Conform to Hashable protocol.
	func hash(into hasher: inout Hasher) {
		hasher.combine(self.questions)
	}

	/// Array of questions.
	var questions = [FullQuestion]()
	
	/// An object that interacts with a cloud service.
	var webService: QuestionProvider?
	
	/// Checks if network is done fetching.
	var isFetching: Bool = false
	
	/// The current question of the game.
	var currentQuestion: FullQuestion?
	
	/// Index of the current question.
	var currentQuestionIndex: Int?
	
	/// Array of alternatives for the question.
	var alternatives = [String]()
	
	/// The user selected alternative among all of them.
	var selectedAlternative: String?
	
	/// Time remaining of the game match.
	var timeRemaining = 30
	
	/// Score of the user.
	var userScore = 0
	
	/// Limit of questions.
	var limit = 5.0
	
	/// The selected difficulty for the questions.
	var selectedDifficulty = Difficulty.easy
	
	/// The selected category for the questions.
	var selectedCategory = Category.filmAndTv
	
	/// Checks if the game ran out of questions.
	var gameIsOver: Bool {
		guard let currentQuestionIndex else {
			return false
		}
		return currentQuestionIndex == self.questions.endIndex - 1
	}
	
	init(
		webService: QuestionProvider = QuestionWebService()
	) {
		self.webService = webService
	}
	
	/// Fetches questions based on game settings.
	func fetchQuestions(limit: Double, category: Category, difficulty: Difficulty) async throws -> QuestionResponse {
		guard let webService else {
			throw NSError(domain: "QuestionViewModel", code: 0)
			// Create network error enum
		}
		
		defer {
			self.isFetching = false
		}
		
		self.isFetching = true
		return try await webService.fetchQuestions(limit: limit, category: category, difficulty: difficulty)
	}
	
	/// Sets a new game by calling fetchQuestions method and defining initial match stats.
	func startGame() {
		Task {
			do {
				let response = try await fetchQuestions(
					limit: limit,
					category: selectedCategory,
					difficulty: selectedDifficulty
				)
				self.questions = response.questions
				self.currentQuestionIndex = 0
				self.currentQuestion = self.questions[currentQuestionIndex ?? 0]
				
				if let currentQuestion {
					var newAlternatives = currentQuestion.incorrectAnswers
					newAlternatives.append(currentQuestion.correctAnswer)
					self.alternatives = newAlternatives.sorted()
				}
				
				self.timeRemaining = 30
				self.selectedAlternative = nil
				self.userScore = 0
			} catch {
				print(error)
			}
		}
	}
	
	/// Jumps to next question and reset match stats.
	func nextQuestion() {
		guard let currentQuestionIndex else { return }
		
		guard !self.gameIsOver else {
			return
		}
		
		if let nextIndex = self.questions.index(
			currentQuestionIndex,
			offsetBy: 1,
			limitedBy: self.questions.endIndex
		) {
			let newQuestion = self.questions[nextIndex]
			self.currentQuestionIndex = nextIndex
			
			var newAlternatives = newQuestion.incorrectAnswers
			newAlternatives.append(newQuestion.correctAnswer)
			self.currentQuestion = newQuestion
			self.alternatives = newAlternatives.sorted()
			
			self.selectedAlternative = nil
			self.timeRemaining = 30
		}
	}
	
	/// Defines selected alternative's color based on right or wrong answers.
	func selectedAlternativeColor() -> Color {
		if self.selectedAlternative == currentQuestion?.correctAnswer && selectedAlternative != nil {
			return .green
		} else if self.selectedAlternative != currentQuestion?.correctAnswer && selectedAlternative != nil {
			return .red
		} else {
			return .accentColor
		}
	}
	
	/// Defines unselected alternatives' color and reveals right answer, if not selected.
	func otherAlternativesColors(alternative: String) -> Color {
		if self.timeRemaining == 0 && alternative == currentQuestion?.correctAnswer || selectedAlternative != nil && alternative == currentQuestion?.correctAnswer {
			return .green
		} else {
			return .gray.opacity(0.2)
		}
	}
	
	/// Calculates user's score based on accuracy and time spent to answer question.
	func addToScore() {
		guard self.selectedAlternative == currentQuestion?.correctAnswer else {
			return self.timeRemaining = 0
		}
		
		if self.timeRemaining > 20 {
			self.userScore += 150
		} else if self.timeRemaining > 10 {
			self.userScore += 100
		} else {
			self.userScore += 50
		}
		
		self.timeRemaining = 0
	}
	
	/// Sets time back to 0.
	func timeIsOver() {
		self.timeRemaining = 0
	}
}



