//
//  FullQuestion.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/30/24.
//

import Foundation

/// An object that represents a question.
struct FullQuestion: Codable, Equatable, Identifiable, Hashable {
	/// Category of the question.
	let category: Category
	
	/// ID of the question.
	let id: String
	
	/// Tags of the question.
	let tags: [String]
	
	/// Difficulty of the question.
	let difficulty: Difficulty
	
	/// Regions of the question.
	let regions: [String]
	
	/// Whether the question is niche or not.
	let isNiche: Bool
	
	/// An object that represents the text of a question.
	let question: Question
	
	/// Correct answer of the question.
	let correctAnswer: String
	
	/// Array of incorrect answers.
	let incorrectAnswers: [String]
	
	/// Type of the question.
	let type: String
}
