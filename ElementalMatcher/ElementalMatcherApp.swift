//
//  ElementalMatcherApp.swift
//  ElementalMatcher
//
//  Created by Josh Charpentier on 12/24/24.
//

import SwiftUI

@main
struct ElementalMatcherApp: App {
  @State var game = ElementalMatcherGame()

  var body: some Scene {
    WindowGroup {
      ElementalMatcherView(viewModel: game)
    }
  }
}
