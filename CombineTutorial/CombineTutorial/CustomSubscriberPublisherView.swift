//
//  CustomSubscriberPublisherView.swift
//  CombineTutorial
//
//  Created by Bruce on 2020/6/5.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import Combine

struct CustomSubscriberPublisherView: View {
  
  let items = ["IntSubscriber"]
  
  var body: some View {
    VStack {
      ForEach(0..<items.count) { index in
        GradientView(title: self.items[index])
        .onTapGesture { self.tap(at: index) }
      }
    }
    .padding()
    .navigationBarTitle("CustomSubscriberPublisherView")
  }
  
  func tap(at index: Int) {
    switch index {
      case 0:
        let publisher = (1...6).publisher.print()
        let subscriber = IntSubscriber()
        publisher.subscribe(subscriber)
      default:
        break
    }
  }
}

// MARK: - Custom Subscriber

final class IntSubscriber: Subscriber {
  typealias Input = Int
  typealias Failure = Never
  
  func receive(subscription: Subscription) {
    subscription.request(.max(2))
  }
  
  func receive(_ input: Int) -> Subscribers.Demand {
    switch input {
      case 1:
        return .max(1)
      default:
        return .none
    }
  }
  
  func receive(completion: Subscribers.Completion<Never>) {
    print("Received completion: \(completion)")
  }
}

//final class DataTaskSubscriber<Input: Decodable>: Subscriber {
//
//  typealias Failure = Error
//
//  func receive(subscription: Subscription) {
//    print("Received subscription")
//    subscription.request(.unlimited)
//  }
//
//  func receive(_ input: Input) -> Subscribers.Demand {
//    print("Received value: \(input)")
//    return .none
//  }
//
//  func receive(completion: Subscribers.Completion<Error>) {
//    print("Received completion  \(completion)")
//  }
//
//}
//
//struct DataTaskPublisher<Output: Decodable>: Publisher {
//
//  typealias Failure = Error
//
//  let urRequest: URLRequest
//
//  func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
//
//  }
//}

// MARK: - Custom Publisher

struct CustomSubscriberPublisherView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSubscriberPublisherView()
  }
}
