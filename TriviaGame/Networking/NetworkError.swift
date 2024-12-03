//
//  NetworkError.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 12/1/24.
//

import Foundation

/// Enum of possible network errors.
enum NetworkError: Error {
	case invalidURL
	case missingJSON
	case loadingError
}
