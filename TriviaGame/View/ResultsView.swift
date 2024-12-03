//
//  ResultsView.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/11/24.
//

import SwiftUI

/// Display results and buttons to restart game or to get back to settings.
///
///  When Restart button is triggered, this view is dismissed back to `GameView`. When Back to Settings button is triggered, `ContentView` is pushed onto the stack.
struct ResultsView: View {
	@Environment(\.dismiss) var dismiss
	@Binding var path: NavigationPath
	
	let viewModel: QuestionViewModel
	
    var body: some View {
		VStack {
			self.finalScoreDisplay
				
			HStack {
				self.restartButton
				self.backToSettingsButton
			}
		}
    }
	
	/// Displays a text indicating the final score of the user.
	private var finalScoreDisplay: some View {
		Text("Your final score is \(viewModel.userScore)!")
			.font(.title)
	}
	
	/// Displays a button that triggers a restart of the game and dismisses this view.
	private var restartButton: some View {
		Button {
			self.viewModel.startGame()
			self.dismiss()
		} label: {
			Text("Restart")
				.foregroundStyle(.white)
				.padding()
				.background(Color.accentColor)
				.clipShape(RoundedRectangle(cornerRadius: 10))
		}
	}
	
	///  Displays a button that triggers a return to ContentView.
	private var backToSettingsButton: some View {
		Button {
			path = NavigationPath()
		} label: {
			Text("Back to settings")
				.foregroundStyle(.white)
				.padding()
				.background(Color.accentColor)
				.clipShape(RoundedRectangle(cornerRadius: 10))
		}
	}
}

