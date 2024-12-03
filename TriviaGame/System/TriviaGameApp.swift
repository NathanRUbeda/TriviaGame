//
//  TriviaGameApp.swift
//  TriviaGame
//
//  Created by Nathan Ubeda on 11/5/24.
//

import SwiftUI

@main
struct TriviaGameApp: App {
	let viewModel: QuestionViewModel
	
	init() {
		let viewModel = QuestionViewModel()
		self.viewModel = viewModel
	}
	
    var body: some Scene {
        WindowGroup {
			ContentView(viewModel: viewModel)
        }
    }
}
