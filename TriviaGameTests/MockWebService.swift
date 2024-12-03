//
//  MockWebService.swift
//  TriviaGameTests
//
//  Created by Nathan Ubeda on 11/28/24.
//

import Foundation
@testable import TriviaGame

/// An object that mimics an interaction with a cloud service using a JSON file.
class MockWebService: WebService, QuestionProvider {
	/// Sends request to get questions based on the given settings.
	/// - Parameters:
	/// - limit: The amount of questions.
	/// - category: The category (subject) of the questions.
	/// - difficulty: The difficulty of the game.
	/// - Returns: A `QuestionResponse` object.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchQuestions(limit: Double, category: TriviaGame.Category, difficulty: TriviaGame.Difficulty) async throws -> QuestionResponse {
		let url: URL? = switch limit {
			case 1:
				switch category {
					case .music:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockMusicEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockMusicMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockMusicHard1JSON", withExtension: "json")
							@unknown default:
							nil
						}
					case .sportAndLeisure:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockSportEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockSportMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockSportHard1JSON", withExtension: "json")
							@unknown default:
								nil
						}
					case .filmAndTv:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockFilmEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockFilmMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockFilmHard1JSON", withExtension: "json")
							@unknown default:
								nil
						}
					case .artsAndLiterature:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockArtsEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockArtsMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockArtsHard1JSON", withExtension: "json")
							@unknown default:
								nil
						}
					case .history:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockHistoryEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockHistoryMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockHistoryHard1JSON", withExtension: "json")
							@unknown default:
								nil
						}
					case .societyAndCulture:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockSocietyEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockSocietyMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockSocietyHard1JSON", withExtension: "json")
							@unknown default:
								nil
						}
					case .science:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockScienceEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockScienceMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockScienceHard1JSON", withExtension: "json")
							@unknown default:
								nil
						}
					case .geography:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockGeographyEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockGeographyMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockGeographyHard1JSON", withExtension: "json")
							@unknown default:
								nil
						}
					case .foodAndDrink:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockFoodEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockFoodMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockFoodHard1JSON", withExtension: "json")
							@unknown default:
								nil
						}
					case .generalKnowledge:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockGeneralEasy1JSON", withExtension: "json")
							case .medium:
								Bundle.main.url(forResource: "mockGeneralMedium1JSON", withExtension: "json")
							case .hard:
								Bundle.main.url(forResource: "mockGeneralHard1JSON", withExtension: "json")
							@unknown default:
								nil
						}
					@unknown default:
						nil
				}
			case 5:
				switch category {
						case .filmAndTv:
						switch difficulty {
							case .easy:
								Bundle.main.url(forResource: "mockFilmEasy5JSON", withExtension: "json")
							default:
								nil
						}
					default:
						nil
				}
			default:
				nil
		}
		
		guard let jsonURL = url else {
			throw NetworkError.missingJSON
		}
		
		guard let data = try? Data(contentsOf: jsonURL) else {
			throw NetworkError.loadingError
		}
		
		return try decode(data)
	}
}
