//
//  QuestionProvider.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/7/24.
//

import Foundation

/// An object that provides questions.
protocol QuestionProvider {
	/// Sends request to get questions based on the given settings.
	/// - Parameters:
	/// - limit: The amount of questions.
	/// - category: The category (subject) of the questions.
	/// - difficulty: The difficulty of the game.
	/// - Returns: A `QuestionResponse` object.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchQuestions(limit: Double, category: Category, difficulty: Difficulty) async throws -> QuestionResponse
}
