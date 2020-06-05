//
//  GradientView.swift
//  CombineTutorial
//
//  Created by Bruce on 2020/6/4.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct GradientView: View {
  let title: String
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
        .cornerRadius(8)
      
      Text(title)
        .foregroundColor(.white)
        .font(.headline)
    }
  }
}
