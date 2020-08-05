//
//  MatchedGeometryEffect.swift
//  Animation
//
//  Created by Bruce on 2020/8/5.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct MatchedGeometryEffect: View {
  @Namespace var nspace
  @State private var flag: Bool = true
  
  var body: some View {
    HStack {
      if flag {
        Rectangle().fill(Color.green)
          .matchedGeometryEffect(id: "geoeffect1", in: nspace)
          .frame(width: 100, height: 100)
      }
      
      Spacer()
      
      Button("Switch") { withAnimation(.easeInOut(duration: 2.0)) { flag.toggle() } }
      
      Spacer()
      
      if !flag {
        Circle().fill(Color.blue)
          .matchedGeometryEffect(id: "geoeffect1", in: nspace)
          .frame(width: 50, height: 50)
      }
    }
  }
}
