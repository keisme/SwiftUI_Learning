//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Bruce on 2020/5/25.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

enum FilterType {
  case none, contacted, uncontacted
}

struct ProspectsView: View {
  @EnvironmentObject var prospects: Prospects
  var filteredProspects: [Prospect] {
    switch filter {
      case .none:
        return prospects.people
      case .contacted:
        return prospects.people.filter { $0.isContacted }
      case .uncontacted:
        return prospects.people.filter { !$0.isContacted }
    }
  }
  
  let filter: FilterType
  var title: String {
    switch filter {
      case .none:
        return "Everyone"
      case .contacted:
        return "Contacted people"
      case .uncontacted:
        return "Uncontacted people"
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(filteredProspects) { prospect in
          VStack(alignment: .leading) {
            Text(prospect.name)
              .font(.headline)
            Text(prospect.emailAddress)
              .foregroundColor(.secondary)
          }
        }
      }
      .navigationBarTitle(title)
      .navigationBarItems(trailing: Button(action: {
        let prospect = Prospect()
        prospect.name = "Bruce"
        prospect.emailAddress = "keisme3.0@gmail.com"
        self.prospects.people.append(prospect)
      }) {
        Image(systemName: "qrcode.viewfinder")
        Text("Scan")
      })
    }
  }
}

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
  }
}
