//
//  CustomTransition.swift
//  Animation
//
//  Created by Bruce on 2020/7/7.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

extension AnyTransition {
  static func moveAndScale(edge: Edge) -> AnyTransition {
    AnyTransition.move(edge: edge).combined(with: .scale(scale: 1.2))
  }
  
  static func moveOrFade(edge: Edge) -> AnyTransition {
    AnyTransition.asymmetric(
      insertion: .move(edge: edge),
      removal: .opacity
    )
  }
}

struct CustomTransition: View {
  @State private var isButtonVisible = true
  
  var body: some View {
    VStack {
      Toggle(isOn: $isButtonVisible.animation()) {
        Text("Show/Hide button")
      }
      
      if isButtonVisible {
        Button(action: {}) {
          Text("Hidden Button")
        }.transition(.moveOrFade(edge: .trailing))
      }
    }
  }
}

struct Test_Previews: PreviewProvider {
  static var previews: some View {
    CustomTransition()
  }
}
