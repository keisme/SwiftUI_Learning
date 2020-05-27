//
//  CardView.swift
//  Flashzilla
//
//  Created by keisme on 2020/5/28.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct CardView: View {
  @State private var isShowingAnswer = false
  let card: Card
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25.0, style: .continuous)
        .fill(Color.white)
        .shadow(radius: 10)
      
      VStack {
        Text(card.prompt)
          .font(.largeTitle)
          .foregroundColor(.black)
        
        if isShowingAnswer {
          Text(card.answer)
            .font(.title)
            .foregroundColor(.gray)
        }
      }
      .padding(20)
      .multilineTextAlignment(.center)
    }
    .frame(width: 450, height: 250)
    .onTapGesture {
        self.isShowingAnswer.toggle()
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card.example)
  }
}
