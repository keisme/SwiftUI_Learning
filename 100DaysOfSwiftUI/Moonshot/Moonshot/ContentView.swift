//
//  ContentView.swift
//  Moonshot
//
//  Created by Bruce on 2020/5/14.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct Astronaut: Codable, Identifiable {
  let id: String
  let name: String
  let description: String
}

struct Mission: Codable, Identifiable {
  struct CrewRole: Codable {
    let name: String
    let role: String
  }
  
  let id: Int
  let launchDate: Date?
  let crew: [CrewRole]
  let description: String
  
  var displayName: String {
    "Apollo \(id)"
  }
  
  var image: String {
    "apollo\(id)"
  }
  
  var formattedLaunchDate: String {
    if let launchDate = launchDate {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
      return formatter.string(from: launchDate)
    } else {
      return "N/A"
    }
  }
}

extension Bundle {
  func decode<T: Codable>(_ file: String) -> T {
    guard let url = self.url(forResource: file, withExtension: nil) else {
      fatalError("Failed to locate \(file) in bundle")
    }
    
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Failed to load \(file) from bundle.")
    }
    
    let formatter = DateFormatter()
    formatter.dateFormat = "y-MM-dd"
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(formatter)
    
    guard let loaded = try? decoder.decode(T.self, from: data) else {
      fatalError("Failed to decode \(file) from bundle")
    }
    
    return loaded
  }
}

struct ContentView: View {
  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")
  
  var body: some View {
    NavigationView {
      List(missions) { mission in
        NavigationLink(destination: Text("Detail view")) {
          Image(mission.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 44, height: 44)
          
          VStack(alignment: .leading) {
            Text(mission.displayName)
              .font(.headline)
            Text(mission.formattedLaunchDate)
          }
        }
      }
      .navigationBarTitle("MoonShot")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
