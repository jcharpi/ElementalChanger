//
//  ElementalMatcherViewModel.swift
//  ElementalMatcher
//
//  Created by Josh Charpentier on 12/24/24.
//

import SwiftUI

@Observable
class ElementalMatcherGame {
  private var model = MatcherGame()

  var cards: [MatcherGame.Card] { model.cards }

  var level: Int { model.level }

  var highScore: Int { (model.completedCount * 100) + (level - 1) }
  
  var background: Color { colorConvert(model.background) }
  
  var levelToOpacity: Double {
    return ((100.0 - Double(level)) / 100)
  }
  
  func colorConvert(_ colorName: String) -> Color {
    switch model.background {
    case "water": return .blue
    case "earth": return .green
    case "fire": return .red
    case "air": return .yellow
    default: return .black
    }
  }
  // MARK: - Intents
  func restart() {
    model = MatcherGame()
  }

  func levelUp() {
    model.shuffle()
  }
  
  func choose(_ card: MatcherGame.Card) {
    model.choose(card)
  }
}
