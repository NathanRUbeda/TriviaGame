//
//  QuestionAlternativeView.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/7/24.
//

import SwiftUI

/// Displays the question's alternative through a button.
struct QuestionAlternativeView: View {
	let viewModel: QuestionViewModel
	let index: Int
	let alternative: String
	
    var body: some View {
		Button {
			self.viewModel.selectedAlternative = alternative
			self.viewModel.addToScore()
		} label: {
			self.buttonLabel
		}
		.disabled(self.viewModel.selectedAlternative != nil || self.viewModel.timeRemaining == 0)
    }
	
	/// Displays texts indicating the alternative's index and body of text.
	private var buttonLabel: some View {
		HStack {
			Text("\(index + 1).")
				.fontWeight(.semibold)
			
			Text(alternative)
				.fontWeight(.semibold)
				.foregroundStyle(.black)
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(
			self.viewModel.selectedAlternative == alternative ? self.viewModel
				.selectedAlternativeColor() : self.viewModel
				.otherAlternativesColors(alternative: alternative)
		)
		.clipShape(RoundedRectangle(cornerRadius: 12))
	}
}
