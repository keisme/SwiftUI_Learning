//
//  ContentView.swift
//  BucketList
//
//  Created by Bruce on 2020/5/19.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct User: Identifiable, Comparable {
  let id = UUID()
  let firstName: String
  let lastName: String
  
  static func < (lhs: User, rhs: User) -> Bool {
    lhs.firstName < rhs.firstName
  }
}

struct ContentView: View {
  @State private var isUnlocked = false
  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var locations = [MKPointAnnotation]()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  @State private var showingEditScreen = false

  let users = [
    User(firstName: "Arnold", lastName: "Rimmer"),
    User(firstName: "Kristine", lastName: "Kochanski"),
    User(firstName: "David", lastName: "Lister"),
    ].sorted()
  
  var body: some View {
    //    ScrollView {
    //      Text("Hello world")
    //        .onTapGesture {
    //          let str = "Test Message"
    //          let url = self.getDocumentsDir().appendingPathComponent("message.txt")
    //          do {
    //            try str.write(to: url, atomically: true, encoding: .utf8)
    //            let input = try String(contentsOf: url)
    //            print(input)
    //          } catch {
    //            print(error.localizedDescription)
    //          }
    //      }
    //
    //      Group {
    //        if loadingState == .loading {
    //          LoadingView()
    //        } else if loadingState == .success {
    //          SuccessView()
    //        } else if loadingState == .failed {
    //          FailedView()
    //        }
    //      }
    //    }
    
    
    ZStack {
      MapView(annotations: locations, centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
        .edgesIgnoringSafeArea(.all)
      
      Circle()
        .fill(Color.blue)
        .opacity(0.3)
        .frame(width: 32, height: 32)
      
      Spacer()
      
      HStack {
        Spacer()
        Button(action: {
          // create a new location
          let newLocation = MKPointAnnotation()
          newLocation.title = "Example location"
          newLocation.coordinate = self.centerCoordinate
          self.locations.append(newLocation)
          self.selectedPlace = newLocation
          self.showingEditScreen = true
        }) {
          Image(systemName: "plus")
        }
        .padding()
        .background(Color.black.opacity(0.75))
        .foregroundColor(.white)
        .font(.title)
        .clipShape(Circle())
        .padding(.trailing)
      }
    }
    .alert(isPresented: $showingPlaceDetails) {
      Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
        // edit this place
        self.showingEditScreen = true
        })
    }
    .sheet(isPresented: $showingEditScreen) {
      if self.selectedPlace != nil {
        EditView(placemark: self.selectedPlace!)
      }
    }
    
    //    VStack {
    //      if self.isUnlocked {
    //        Text("Unlocked")
    //      } else {
    //        Text("Locked")
    //      }
    //    }
    //    .onAppear(perform: authenticate)
  }
  
  func getDocumentsDir() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func authenticate() {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "We need to unlock your data."
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
        DispatchQueue.main.async {
          if success {
            // authenticated successfully
            self.isUnlocked = true
          } else {
            // there was a problem
          }
        }
      }
    } else {
      // no biometrics
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
