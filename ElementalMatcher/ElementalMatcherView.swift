//
//  ContentView.swift
//  ElementalMatcher
//
//  Created by Josh Charpentier on 12/24/24.
//

import SwiftUI

struct ElementalMatcherView: View {
  @Bindable var viewModel: ElementalMatcherGame
  
  var body: some View {
      VStack {
        Spacer()
        HStack {
          Text("Level: \(viewModel.level)")
          Spacer()
          Text("Total: \(viewModel.highScore)")
        }.padding(.horizontal)
        Spacer()
        cards
          .animation(.default, value: viewModel.cards)
        Spacer()
        Button("Reset") {
          viewModel.restart()
        }.tint(.black)
        Spacer()
      }
      .foregroundStyle(.primary)
      .font(.title)
      .padding()
      .background(viewModel.background.opacity(viewModel.levelToOpacity))
  }
  
  var cards: some View {
    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
      ForEach(viewModel.cards) { card in
        CardView(card)
          .onTapGesture {
            viewModel.choose(card)
          }
      }
    }
  }
}

struct CardView: View {
  let card: MatcherGame.Card
  
  init(_ card: MatcherGame.Card) {
    self.card = card
  }
  
  var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .stroke(card.isSelected ? Color.primary : Color.gray, lineWidth: 4)
      .aspectRatio(contentMode: .fit)
      .padding(10)
      .overlay(Text("\(card.element.symbol)")
        .font(.system(size: 75))
      )
  }
}

#Preview {
  ElementalMatcherView(viewModel: ElementalMatcherGame())
}
