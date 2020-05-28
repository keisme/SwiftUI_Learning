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
  
  var body: some View {
    NavigationView {
      List(resorts) { resort in
        NavigationLink(destination: Text(resort.name)) {
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
        }
      }
      .navigationBarTitle("Resorts")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
