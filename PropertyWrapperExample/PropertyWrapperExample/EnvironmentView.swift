//
//  EnvironmentView.swift
//  PropertyWrapperExample
//
//  Created by Bruce on 2020/5/21.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct DismissColorKey: EnvironmentKey {
  public static let defaultValue = Color.red
}

extension EnvironmentValues {
  var dismissColor: Color {
    set { self[DismissColorKey.self] = newValue }
    get { self[DismissColorKey.self] }
  }
}

struct EnvironmentView: View {
  @Environment(\.presentationMode) private var presentationMode
  @Environment(\.dismissColor) private var dismissColor
  
  var body: some View {
    VStack {
      Button("Dismiss\nDismiss") {
        self.presentationMode.wrappedValue.dismiss()
      }
      .environment(\.lineLimit, 1)
      
      Button(action: {
        self.presentationMode.wrappedValue.dismiss()
      }) {
        Text("Red Dismiss")
        .foregroundColor(dismissColor)
      }
    }
  }
}

struct EnvironmentView_Previews: PreviewProvider {
  static var previews: some View {
    EnvironmentView()
  }
}
