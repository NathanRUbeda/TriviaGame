//
//  Category.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/30/24.
//

import Foundation

/// Enum of available categories for the question.
enum Category: String, Codable, CaseIterable, Hashable {
	case music = "music"
	case sportAndLeisure = "sport_and_leisure"
	case filmAndTv = "film_and_tv"
	case artsAndLiterature = "arts_and_literature"
	case history = "history"
	case societyAndCulture = "society_and_culture"
	case science = "science"
	case geography = "geography"
	case foodAndDrink = "food_and_drink"
	case generalKnowledge = "general_knowledge"
}
