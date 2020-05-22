//
//  EnvironmentObjectView.swift
//  PropertyWrapperExample
//
//  Created by Bruce on 2020/5/22.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
  @Published var name = "Bruce"
}

struct ViewA: View {
  var body: some View {
    ViewB()
    .frame(width: 300, height: 300)
      .background(Color.red)
  }
}

struct ViewB: View {
  var body: some View {
    ViewC()
    .frame(width: 200, height: 200)
    .background(Color.black)
  }
}

struct ViewC: View {
  @EnvironmentObject var user: User
  
  var body: some View {
    Text(user.name)
    .frame(width: 100, height: 100)
      .background(Color.white)
  }
}

struct EnvironmentObjectView: View {
  private let user = User()
  
  var body: some View {
    ViewA().environmentObject(user)
  }
}

struct EnvironmentObjectView_Previews: PreviewProvider {
  static var previews: some View {
    EnvironmentObjectView()
  }
}
