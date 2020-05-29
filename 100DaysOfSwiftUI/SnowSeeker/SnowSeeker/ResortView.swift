//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Bruce on 2020/5/29.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct Facility: Identifiable {
  let id = UUID()
  var name: String
  
  var icon: some View {
    let icons = [
      "Accommodation": "house",
      "Beginners": "1.circle",
      "Cross-country": "map",
      "Eco-friendly": "leaf.arrow.circlepath",
      "Family": "person.3"
    ]
    
    if let iconName = icons[name] {
      let image = Image(systemName: iconName)
        .accessibility(label: Text(name))
        .foregroundColor(.secondary)
      return image
    } else {
      fatalError("Unknown facility type: \(name)")
    }
  }
  
  var alert: Alert {
    let messages = [
      "Accommodation": "This resort has popular on-site accommodation.",
      "Beginners": "This resort has lots of ski schools.",
      "Cross-country": "This resort has many cross-country ski routes.",
      "Eco-friendly": "This resort has won an award for environmental friendliness.",
      "Family": "This resort is popular with families."
    ]
    
    if let message = messages[name] {
      return Alert(title: Text(name), message: Text(message))
    } else {
      fatalError("Unknown facility type: \(name)")
    }
  }
}

struct ResortView: View {
  let resort: Resort
  @Environment(\.horizontalSizeClass) var sizeClass
  @State private var selectedFacility: Facility?
  @EnvironmentObject var favorites: Favorites
  
  var body: some View {
  ScrollView {
    VStack(alignment: .leading, spacing: 0) {
      Image(decorative: resort.id)
        .resizable()
        .scaledToFit()
      
      Group {
        HStack {
          if sizeClass == .compact {
            Spacer()
            VStack { ResortDetailsView(resort: resort) }
            VStack { SkiDetailsView(resort: resort) }
            Spacer()
          } else {
            ResortDetailsView(resort: resort)
            Spacer().frame(height: 0)
            SkiDetailsView(resort: resort)
          }
        }
        .font(.headline)
        .foregroundColor(.secondary)
        .padding(.top)
        
        Text(resort.description)
          .padding(.vertical)
        
        Text("Facilities")
          .font(.headline)
        
        //          Text(ListFormatter.localizedString(byJoining: resort.facilities))
        //            .padding(.vertical)HStack {
        ForEach(resort.facilityTypes) { facility in
          facility.icon
            .font(.title)
            .onTapGesture {
              self.selectedFacility = facility
          }
        }
      }
      .padding(.vertical)
      
      Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites")  {
        if self.favorites.contains(self.resort) {
          self.favorites.remove(self.resort)
        } else {
          self.favorites.add(self.resort)
        }
      }
      .padding()
    }
    .padding(.horizontal)
  }
    .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    .alert(item: $selectedFacility) { facility in
        facility.alert
    }
  }
}

extension String: Identifiable {
  public var id: String { self }
}
