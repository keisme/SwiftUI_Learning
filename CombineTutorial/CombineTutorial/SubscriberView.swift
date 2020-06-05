//
//  SubscriberView.swift
//  CombineTutorial
//
//  Created by Bruce on 2020/6/4.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

class SomeObject {
  var value: String = "" {
    didSet {
      print(value)
    }
  }
}

struct SubscriberView: View {
    var body: some View {
      GradientView(title: "assign")
        .frame(width: 200, height: 150)
        .onTapGesture {
          let obj = SomeObject()
          let pub = ["Hello", "world!"].publisher
          _ = pub.assign(to: \.value, on: obj)
          print(obj.value)
      }
    }
}

struct SubscriberView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberView()
    }
}
