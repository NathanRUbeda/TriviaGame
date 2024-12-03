//
//  ContentView.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/5/24.
//

import SwiftUI

/// Displays a NavigationStack and settings to start the game.
///
/// When Start Game button is triggered, `GameView` is pushed onto the stack.
struct ContentView: View {
	@Bindable var viewModel: QuestionViewModel
	@State private var path = NavigationPath()

	var body: some View {
		NavigationStack(path: $path) {
			VStack {
				Text("Amount of questions: \(viewModel.limit.formatted())")
				self.questionsSlider
				
				Text("Select a difficulty")
				self.difficultyPicker
				
				Text("Select the categories")
				self.categoryPicker
				
				Spacer()
				
				self.gameNavigationLink
			}
			.padding()
			.navigationTitle("Game Settings")
			.navigationDestination(for: QuestionViewModel.self) { viewModel in
				GameView(path: $path, viewModel: viewModel)
			}
		}
	}
	
	/// Displays a slider for selecting the number of questions.
	private var questionsSlider: some View {
		Slider(value: $viewModel.limit, in: 1...49, step: 1)
			.padding(.bottom)
	}
	
	/// Displays a picker for selecting the game's difficulty.
	private var difficultyPicker: some View {
		Picker("Select a difficulty", selection: $viewModel.selectedDifficulty) {
			ForEach(Difficulty.allCases, id: \.self) { difficulty in
				Text(difficulty.rawValue.capitalized)
			}
		}
		.pickerStyle(.segmented)
		.padding(.bottom)
	}
	
	/// Displays a picker for selecting the game's category..
	private var categoryPicker: some View {
		Picker("Select a category", selection: $viewModel.selectedCategory) {
			ForEach(Category.allCases, id: \.self) { difficulty in
				Text((difficulty.rawValue.replacingOccurrences(of: "_", with: " ").capitalized))
			}
		}
		.pickerStyle(.menu)
		.padding(.bottom)
	}
	
	/// Displays a button that pushes `GameView` onto the stack and starts the game.
	private var gameNavigationLink: some View {
		NavigationLink(value: self.viewModel) {
			Text("Start Game")
				.frame(maxWidth:.infinity)
				.padding(.vertical)
				.background(Color.blue)
				.foregroundColor(.white)
				.clipShape(RoundedRectangle(cornerRadius: 10))
				.padding()
		}

	}
}

