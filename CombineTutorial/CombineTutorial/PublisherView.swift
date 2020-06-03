//
//  PublisherView.swift
//  CombineTutorial
//
//  Created by Bruce on 2020/6/3.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import Combine

enum SomeError: Error {
  case someError
  
  var localizedDescription: String {
    return "Some Error"
  }
}

struct PublisherView: View {
  @State private var buttonTitle = "Tap me!"
  
  var body: some View {
    Button(buttonTitle) {
      let publisher = Future<String, SomeError>({ (promise) in
        if Bool.random() {
          promise(.success("Succeed"))
        } else {
          promise(.failure(.someError))
        }
      })
      
      _ = publisher.sink(receiveCompletion: {
        switch $0 {
          case .finished:
            print($0)
          case .failure(let error):
            print(error)
            self.buttonTitle = error.localizedDescription
        }
      }, receiveValue: {
        print($0)
        self.buttonTitle = $0
      })
    }
  }
}

struct PublisherView_Previews: PreviewProvider {
  static var previews: some View {
    PublisherView()
  }
}
