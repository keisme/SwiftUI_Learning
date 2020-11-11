//
//  SubjectView.swift
//  CombineTutorial
//
//  Created by Bruce on 2020/6/9.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import Combine

struct SubjectView: View {
  private let items = [
    "PassthroughSubject",
    "CurrentValueSubject"
  ]
  
  var body: some View {
    ForEach(0..<items.count) { index in
      GradientView(title: self.items[index])
      .onTapGesture { self.tap(at: index) }
    }
    .padding()
    .navigationBarTitle("Convenience Publishers")
  }
  
  func tap(at index: Int) {
    switch index {
      case 0:
        let subscriber = StringSubscriber()
        let subject = PassthroughSubject<String, MyError>()
        subject.subscribe(subscriber)
        let subscription = subject.sink(receiveCompletion: { print($0) }, receiveValue: { print("sink: ", $0) })
        subject.send("Hello")
        subject.send("World")
        // subject.send("Hello2")
        // subject.send("World2")
        subscription.cancel()
        subject.send("Still there?")
        subject.send(completion: .finished)
        subject.send("How about another one?")
//        subject.send(completion: .failure(MyError.test))
      case 1:
        let subject = CurrentValueSubject<Int, Never>(0)
        let subscription = subject.sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
        subject.send(1)
        subject.send(2)
        print("Current value: ", subject.value)
        subject.value = 3
        print("Current value: ", subject.value)
      default:
      break
    }
  }
}

// MARK: - PassthroughSubject

enum MyError: Error {
  case test
}

final class StringSubscriber: Subscriber {
  typealias Input = String
  typealias Failure = MyError
  
  func receive(subscription: Subscription) {
    subscription.request(.max(2))
  }
  
  func receive(_ input: String) -> Subscribers.Demand {
    print("Received value", input)
    
    return input == "World" ? .max(1) : .none
  }
  
  func receive(completion: Subscribers.Completion<MyError>) {
    print("Received completion", completion)
  }
}

// MARK: - CurrentValueSubject

struct SubjectView_Previews: PreviewProvider {
  static var previews: some View {
    SubjectView()
  }
}
