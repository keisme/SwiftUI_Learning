//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Bruce on 2020/5/25.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import CodeScanner

enum FilterType {
  case none, contacted, uncontacted
}

struct ProspectsView: View {
  @EnvironmentObject var prospects: Prospects
  @State private var isShowingScanner = false
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
  
  func handleScan(result: Result<String, CodeScannerView.ScanError>) {
    self.isShowingScanner = false
    switch result {
    case .success(let code):
      let details = code.components(separatedBy: "\n")
      guard details.count == 2 else { return }
      let person = Prospect()
      person.name = details[0]
      person.emailAddress = details[1]
      self.prospects.people.append(person)
    case .failure(let error):
      print("Scanning failed: \(error.localizedDescription)")
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
        self.isShowingScanner = true
      }) {
        Image(systemName: "qrcode.viewfinder")
        Text("Scan")
      })
        .sheet(isPresented: $isShowingScanner) {
          CodeScannerView(codeTypes: [.qr], simulatedData: "Bruce\nkeisme3.0@gmail.com", completion: self.handleScan)
      }
    }
  }
}

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
  }
}
