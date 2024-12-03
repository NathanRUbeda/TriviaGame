//
//  Difficulty.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/30/24.
//

import Foundation

/// Enum of available difficulties for the question.
enum Difficulty: String, Codable, CaseIterable, Hashable {
	case easy = "easy"
	case medium = "medium"
	case hard = "hard"
}
