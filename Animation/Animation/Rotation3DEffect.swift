//
//  Rotation3DEffect.swift
//  Animation
//
//  Created by Bruce on 2020/7/2.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct Rotation3DEffect: View {
  private let weathers = ["sun.max", "cloud", "moon", "wind", "snow"]
  
  @State var dragAmount = CGSize.zero
  
  var body: some View {
    VStack {
      GeometryReader { geo in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 20) {
            ForEach(self.weathers, id: \.self) { value in
              GeometryReader { imageGeo in
                Image(systemName: value)
                  .foregroundColor(.white)
                  .frame(width: (geo.size.width - 80) / 3, height: (geo.size.width - 80) / 3)
                  .background(Color.blue)
                  .cornerRadius(8)
                  .rotation3DEffect(.degrees(-Double(imageGeo.frame(in: .global).midX - geo.size.width / 2) / 3), axis: (x: 0, y: 1, z: 0))
              }
              .frame(width: (geo.size.width - 80) / 3)
            }
          }
          .padding(20)
        }
      }
      
      Spacer()
      
      GeometryReader { geo in
        Rectangle()
          .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
          .frame(width: 300, height: 200)
          .clipShape(RoundedRectangle(cornerRadius: 20))
          .rotation3DEffect(.degrees(-Double(self.dragAmount.width) / 20), axis: (x: 0, y: 1, z: 0))
          .rotation3DEffect(.degrees(Double(self.dragAmount.height / 20)), axis: (x: 1, y: 0, z: 0))
          .offset(self.dragAmount)
          .gesture(
            DragGesture()
              .onChanged { self.dragAmount = $0.translation }
              .onEnded { _ in
                withAnimation(.spring()) {
                  self.dragAmount = .zero
                }
            }
        )
      }
    }
  }
}

struct Rotation3DEffect_Previews: PreviewProvider {
  static var previews: some View {
    Rotation3DEffect()
  }
}
