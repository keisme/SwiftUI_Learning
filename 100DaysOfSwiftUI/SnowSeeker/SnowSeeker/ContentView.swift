//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Bruce on 2020/5/28.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.horizontalSizeClass) var sizeClass
  let resorts: [Resort] = Bundle.main.decode("resorts.json")
  @ObservedObject var favorites = Favorites()
  
  var body: some View {
    NavigationView {
      List(resorts) { resort in
        NavigationLink(destination: ResortView(resort: resort)) {
          Image(resort.country)
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 25)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(RoundedRectangle(cornerRadius: 5)
              .stroke(Color.black, lineWidth: 1))
          
          VStack(alignment: .leading) {
            Text(resort.name)
              .font(.headline)
            Text("\(resort.runs) runs")
              .foregroundColor(.secondary)
          }
          .layoutPriority(1)
          
          if self.favorites.contains(resort) {
            Spacer()
            Image(systemName: "heart.fill")
              .foregroundColor(.red)
          }
        }
      }
      .navigationBarTitle("Resorts")
      
      WelcomeView()
    }
  .environmentObject(favorites)
  }
}

struct WelcomeView: View {
  var body: some View {
    VStack {
      Text("Welcome to SnowSeeker!")
        .font(.largeTitle)
      
      Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
        .foregroundColor(.secondary)
    }
  }
}

extension View {
  func phoneOnlyStackNavigationView() -> some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return AnyView(self.navigationViewStyle((StackNavigationViewStyle())))
    } else {
      return AnyView(self)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
