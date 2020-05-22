//
//  StateView.swift
//  PropertyWrapperExample
//
//  Created by Bruce on 2020/5/20.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct WeatherView: View {
  @Binding var weather: Weather
  @Binding var mutableWeather: Bool
  
  var body: some View {
    Image(systemName: weather.imageName)
      .resizable()
      .scaledToFill()
      .frame(width: 150, height: 150)
      .onTapGesture {
        self.mutableWeather = true
        let random = Int.random(in: 0..<Weather.allCases.count)
        self.weather = Weather.allCases[random]
    }
  }
}

enum Weather: String, CaseIterable {
  case sun = "Sun"
  case cloud = "Cloud"
  case rain = "Rain"
  case snow = "Snow"
  
  var imageName: String {
    switch self {
      case .sun:
        return "sun.max"
      case .cloud:
        return "cloud"
      case .rain:
        return "cloud.rain"
      case .snow:
        return "snow"
    }
  }
}

struct StateView: View {
  @State private var weather: Weather = .sun
  @State private var mutableWeather = false
  
  var body: some View {
    VStack {
      Toggle(isOn: $mutableWeather) {
        Text(mutableWeather ? "Mutable" : "Immutable")
      }
      .padding()
      // add weather view
      WeatherView(weather: $weather, mutableWeather: $mutableWeather)
      Spacer()
    }
    .navigationBarTitle("Weather", displayMode: .inline)
    .navigationBarItems(trailing: Button(action: {
      if self.mutableWeather {
        let random = Int.random(in: 0..<Weather.allCases.count)
        self.weather = Weather.allCases[random]
      }
    }) {
      Text(weather.rawValue)
    })
  }
}

struct StateView_Previews: PreviewProvider {
  static var previews: some View {
    StateView()
  }
}
