//
//  QuestionWebService.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/7/24.
//

import Foundation

/// An object that interacts with a cloud service.
class QuestionWebService: WebService, QuestionProvider {
	/// Sends request to get questions based on the given settings.
	/// - Parameters:
	/// - limit: The amount of questions.
	/// - category: The category (subject) of the questions.
	/// - difficulty: The difficulty of the game.
	/// - Returns: A `QuestionResponse` object.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchQuestions(limit: Double, category: Category, difficulty: Difficulty) async throws -> QuestionResponse {
		return try await self.dispatch(
			using: WebServiceRequest(
				url: "https://the-trivia-api.com/v2/questions",
				httpMethod: "GET",
				endpoint: "",
				headers: nil,
				queries: [
					URLQueryItem(name: "limit", value: String(limit)),
					URLQueryItem(name: "categories", value: category.rawValue),
					URLQueryItem(name: "difficulties", value: difficulty.rawValue)
				]
			)
		)
	}
}
