//
//  ElementalMatcherModel.swift
//  ElementalMatcher
//
//  Created by Josh Charpentier on 12/24/24.
//

import Foundation

struct MatcherGame {
  private(set) var cards: [Card]
  private(set) var level = 1
  private(set) var completedCount = 0
  private(set) var background: String
  
  private var selectedCards: [Card] = []
  
  init() {
    self.cards = []
    for element in Elements.allCases {
      cards.append(Card(element: element, content: element.symbol, id: "\(element.name)1"))
      cards.append(Card(element: element, content: element.symbol, id: "\(element.name)2"))
      cards.append(Card(element: element, content: element.symbol, id: "\(element.name)3"))
    }
    cards.shuffle()
    background = Elements.allCases.randomElement()?.name ?? Elements.water.name
  }

  mutating func shuffle() {
    cards.shuffle()
    background = Elements.allCases.randomElement()?.name ?? Elements.water.name
  }
  
  mutating func choose(_ card: Card) {
    guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }
    
    if cards[index].isSelected {
      selectedCards.removeAll { $0.id == card.id }
      cards[index].isSelected = false
    } else if selectedCards.count < 3 {
      selectedCards.append(cards[index])
      cards[index].isSelected = true
      checkRoundDone()
    }
    
    if level == 100 {
      resetSelected()
      completedCount += 1
      level = 0
      shuffle()
    }
  }
  
  mutating func checkRoundDone() {
      guard selectedCards.count == 3 else { return }

      let match = selectedCards.allSatisfy { $0.element.name == background }
      resetSelected()
      level = match ? level + 1 : 1
      selectedCards.removeAll()
      shuffle()
  }
  
  mutating func resetSelected() {
    selectedCards.forEach { card in
      if let index = cards.firstIndex(where: { $0.id == card.id }) {
          cards[index].isSelected = false
      }
    }
  }

  struct Card: Equatable, Identifiable {
    var element: Elements
    var isSelected = false
    let content: String
    
    var id: String
  }
}

enum Elements: CaseIterable {
  case water
  case earth
  case fire
  case air
  
  var name: String {
    switch self {
    case .water: return "water"
    case .earth: return "earth"
    case .fire: return "fire"
    case .air: return "air"
    }
  }
  
  var symbol: String {
    switch self {
    case .water: return "💧"
    case .earth: return "🪨"
    case .fire: return "🔥"
    case .air: return "💨"
    }
  }
}
