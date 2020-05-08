//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bruce on 2020/5/8.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var showingAlert = false
  
  var body: some View {
    VStack(spacing: 20) {
      HStack(spacing: 20) {
        Text("First")
        Text("First")
        Text("First")
      }
      HStack(spacing: 20) {
        Text("Second")
        Text("Second")
        Text("Second")
      }
      HStack(spacing: 20) {
        Text("Third")
        Text("Third")
        Text("Third")
      }
      
      ZStack {
        Color.red.frame(width: 200, height: 44)
        Text("Your content")
      }
      
      LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
      
      RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
      
      AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
        .frame(width: 100, height: 100)
        .cornerRadius(50)
      
      Button(action: {
        print("Button was tapped")
      }) {
        HStack(spacing: 10) {
          Image(systemName: "pencil").renderingMode(.original)
          Text("Edit")
        }
      }
      

      //      SwiftUI will automatically set showingAlert back to false when the alert is dismissed
      Button("Show Alert") {
        self.showingAlert = Bool.random()
      }
      .alert(isPresented: $showingAlert) {
        Alert(title: Text("Hello SwiftUI"), message: Text("This is some message"), dismissButton: .default(Text("OK")))
      }
      
      ZStack {
        Color.red.edgesIgnoringSafeArea(.all)
        Text("Your content")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewDevice("iPhone XS")
  }
}
