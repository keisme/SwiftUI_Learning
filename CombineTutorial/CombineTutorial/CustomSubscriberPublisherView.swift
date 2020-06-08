//
//  CustomSubscriberPublisherView.swift
//  CombineTutorial
//
//  Created by Bruce on 2020/6/5.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import Combine

struct MovieModel: Decodable {
  
}

struct CustomSubscriberPublisherView: View {
  
  let items = ["IntSubscriber", "DecodedDataTaskPublisher"]
  
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
      case 1:
        let request = URLRequest(url: URL(string: "https://douban.uieee.com/v2/movie/top250")!)
        let publisher: URLSession.DecodedDataTaskPublisher<MovieModel> = URLSession.shared.decodedDataTaskPublisher(for: request)
        publisher.sink(receiveCompletion: { print($0) }, receiveValue: { print($0) }).store(in: &subscriptions)
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

// MARK: - Custom Publisher

extension URLSession {
  struct DecodedDataTaskPublisher<Output: Decodable>: Publisher {
    typealias Failure = Error

    let urlRequest: URLRequest
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
      let subscription = DecodedDataTaskSubscription(urlRequest: urlRequest, subscriber: subscriber)
      subscriber.receive(subscription: subscription)
    }
  }

  func decodedDataTaskPublisher<Output: Decodable>(for urlRequest: URLRequest) -> DecodedDataTaskPublisher<Output> {
    return DecodedDataTaskPublisher<Output>(urlRequest: urlRequest)
  }
}

extension URLSession.DecodedDataTaskPublisher {
  class DecodedDataTaskSubscription<Output: Decodable, S: Subscriber>: Subscription
    where S.Input == Output, S.Failure == Error {

    private let urlRequest: URLRequest
    private var subscriber: S?

    init(urlRequest: URLRequest, subscriber: S) {
      self.urlRequest = urlRequest
      self.subscriber = subscriber
    }

    func request(_ demand: Subscribers.Demand) {
      if demand > 0 {
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
          defer { self?.cancel() }

          if let data = data {
            do {
              let result = try JSONDecoder().decode(Output.self, from: data)
              self?.subscriber?.receive(result)
              self?.subscriber?.receive(completion: .finished)
            } catch {
              self?.subscriber?.receive(completion: .failure(error))
            }
          } else if let error = error {
            self?.subscriber?.receive(completion: .failure(error))
          }
        }.resume()
      }
    }

    func cancel() {
      subscriber = nil
    }
  }
}

struct CustomSubscriberPublisherView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSubscriberPublisherView()
  }
}
