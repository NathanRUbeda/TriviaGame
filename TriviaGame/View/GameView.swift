//
//  GameView.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/10/24.
//

import SwiftUI

/// Displays game matches.
struct GameView: View {
	@Bindable var viewModel: QuestionViewModel
	@Binding var path: NavigationPath
	@State private var showPopover = false
	
	private var canGoToNext: Bool {
		return !self.viewModel.questions.isEmpty && !self.viewModel.gameIsOver && self.viewModel.selectedAlternative != nil && self.viewModel.isFetching == false || self.viewModel.timeRemaining == 0 && !self.viewModel.gameIsOver
	}
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	init(
		path: Binding<NavigationPath>,
		viewModel: QuestionViewModel
	) {
		self._path = path
		self.viewModel = viewModel
		viewModel.startGame()
	}
	
	var body: some View {
		VStack {
			if let currentQuestion = viewModel.currentQuestion {
				self.timeAndCountHeader
				self.scoreDisplay
		
				Text(currentQuestion.question.text)
				self.alternatives
				
				Spacer()
				
				if self.viewModel.gameIsOver {
					self.resultsButton
				}
				
				self.nextButton
			}
		}
		.padding(.horizontal)
		.navigationBarBackButtonHidden(true)
		.overlay {
			if self.viewModel.isFetching {
				ProgressView()
			}
		}
		.popover(isPresented: $showPopover) {
			ResultsView(path: $path, viewModel: viewModel)
		}
	}
	
	/// Displays texts indicating a time counter and a question count tracker.
	private var timeAndCountHeader: some View {
		HStack {
			Image(systemName: "clock")
			Text("\(viewModel.timeRemaining)")
				.foregroundStyle(viewModel.timeRemaining > 10 ? .black : .red)
				.onReceive(timer) { _ in
					if viewModel.timeRemaining > 0 {
						self.viewModel.timeRemaining -= 1
					}
				}
			
			Spacer()
			Text("\((self.viewModel.currentQuestionIndex ?? 0) + 1) / \(self.viewModel.questions.count)")
		}
		.padding()
	}
	
	/// Displays a text indicating the user's score.
	private var scoreDisplay: some View {
		Text("Score: \(viewModel.userScore)")
			.padding(.bottom)
	}
	
	/// Displays a `QuestionAlternativeView` for each of the question's alternatives.
	private var alternatives: some View {
		ForEach(Array(viewModel.alternatives.enumerated()), id: \.offset) { index, alternative in
			QuestionAlternativeView(viewModel: viewModel, index: index, alternative: alternative)
		}
	}
	
	/// Displays a button that triggers a method responsible for jumping to the next question.
	private var nextButton: some View {
		Button {
			self.viewModel.nextQuestion()
		} label: {
			Text("Next")
				.foregroundStyle(.white)
				.padding()
				.frame(maxWidth: .infinity)
				.background(Color.accentColor)
				.clipShape(RoundedRectangle(cornerRadius: 10))
				.padding(.bottom)
		}
		.disabled(!self.canGoToNext)
	}
	
	
	/// Displays a button that triggers a method responsible for showing the results through a popover.
	private var resultsButton: some View {
		Button {
			self.viewModel.timeIsOver()
			self.showPopover = true
		} label: {
			Text("Results")
				.foregroundStyle(.white)
				.padding()
				.frame(maxWidth: .infinity)
				.background(Color.accentColor)
				.clipShape(RoundedRectangle(cornerRadius: 10))
		}
		.disabled(self.viewModel.timeRemaining > 0)
	}
}
