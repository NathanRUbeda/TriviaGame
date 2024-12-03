//
//  QuestionResponse.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/30/24.
//

import Foundation

/// An object that represents an array of questions.
struct QuestionResponse: Codable, Hashable {
	/// Array of questions retrivied from API call.
	let questions: [FullQuestion]
	
	/// Initialize decoded container under questions array.
	init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		self.questions = try container.decode([FullQuestion].self)
	}
}
