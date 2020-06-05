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
  
  private let publishers = ["Future", "Just", "Deferred", "Empty", "Fail", "Record"]
  
  var body: some View {
    VStack {
      ForEach(0..<publishers.count) { index in
        GradientView(title: self.publishers[index])
          .onTapGesture { self.tap(at: index) }
      }
    }
    .padding()
    .navigationBarTitle("Convenience Publishers")
  }
  
  func tap(at index: Int) {
    switch index {
      case 0:
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
          }
        }, receiveValue: { print($0) })
      case 1:
        _ = Just("You have tapped!")
          .sink(receiveCompletion: { print($0) }) { print($0) }
      case 2:
        let futurePublisher = Future<Data, Error> { (promise) in
          print("Future start")
          let request = URLRequest(url: URL(string: "https://douban.uieee.com/v2/movie/top250")!)
          URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
              promise(.success(data))
            } else {
              promise(.failure(error!))
            }
          }.resume()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          print("Future time is out")
          futurePublisher.sink(receiveCompletion: { print($0) }, receiveValue: { print($0) }).store(in: &subscriptions)
        }
        
        let deferredPublisher = Deferred<Future<Data, Error>> {
          print("Deferred start") 
          return Future<Data, Error> { (promise) in
            print("Future start")
            let request = URLRequest(url: URL(string: "https://douban.uieee.com/v2/movie/top250")!)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
              if let data = data {
                promise(.success(data))
              } else {
                promise(.failure(error!))
              }
            }.resume()
          }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          print("Deferred time is out")
          deferredPublisher.sink(receiveCompletion: { print($0) }, receiveValue: { print($0) }).store(in: &subscriptions)
      }
      case 3:
        let flag = Bool.random()
        print(flag)
        // completeImmediately
        // If `true`, the publisher finishes immediately after sending a subscription to the subscriber. If `false`, it never completes.
        _ = Empty<String, Never>(completeImmediately: flag)
          .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
      case 4:
        _ = Fail(error: SomeError.someError)
          .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
      case 5:
        let publisher = Record<Int, Never> { value in
          value.receive(1)
          value.receive(2)
          value.receive(3)
          value.receive(completion: .finished)
        }
        _ = publisher.sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
      default:
        break
    }
  }
}

struct PublisherView_Previews: PreviewProvider {
  static var previews: some View {
    PublisherView()
  }
}
