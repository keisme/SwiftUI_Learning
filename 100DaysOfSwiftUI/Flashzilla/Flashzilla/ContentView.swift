//
//  ContentView.swift
//  Flashzilla
//
//  Created by keisme on 2020/5/26.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
//  @State private var offset = CGSize.zero
//  @State private var isDragging = false
//
//  var body: some View {
//    let dragGesture = DragGesture()
//      .onChanged { value in self.offset = value.translation}
//      .onEnded { _ in
//        withAnimation {
//          self.offset = .zero
//          self.isDragging = false
//        }
//    }
//
//    let pressGesture = LongPressGesture()
//      .onEnded { value in
//        withAnimation {
//          self.isDragging = true
//        }
//    }
//
//    let combined = pressGesture.sequenced(before: dragGesture)
//
//    return Circle()
//      .fill(Color.red)
//      .frame(width: 64, height: 64)
//      .scaleEffect(isDragging ? 1.5 : 1)
//      .offset(offset)
//      .gesture(combined)
  
  
  
  @State private var engine: CHHapticEngine?
//
//  var body: some View {
//    Text("Hello world!")
//    .onAppear(perform: prepareHaptics)
//    .onTapGesture(perform: complexSuccess)
//  }
  
  
  
//  var body: some View {
//    ZStack {
//      Rectangle()
//        .fill(Color.blue)
//        .frame(width: 300, height: 300)
//        .onTapGesture {
//          print("Rectangle tapped!")
//      }
//
//      Circle()
//        .fill(Color.red)
//        .frame(width: 300, height: 300)
//        .contentShape(Rectangle()) // 指定圆的交互范围是矩形
//        .onTapGesture {
//          print("Circle tapped!")
//      }
//       // .allowsHitTesting(false) // 可以禁用交互
//    }
//  }
  
  
   
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  @State private var counter = 0
  
  var body: some View {
    Text("Hello, World!")
      .onReceive(timer) { time in
        if self.counter == 5 {
          self.timer.upstream.connect().cancel()
        } else {
          print("The time is now \(time)")
        }
        
        self.counter += 1
    }
  }
}

extension ContentView {
  func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
  }
  
  func prepareHaptics() {
    guard  CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    do {
      self.engine = try CHHapticEngine()
      try engine?.start()
    } catch {
      print("There was an error creating the engine: \(error.localizedDescription)")
    }
  }
  
  func complexSuccess() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    var events = [CHHapticEvent]()
//    let intesity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intesity, sharpness], relativeTime: 0)
//    events.append(event)
    
//    for i in stride(from: 0, to: 1, by: 0.1) {
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
//        events.append(event)
//    }

    
    for i in stride(from: 0, to: 1, by: 0.1) {
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
        events.append(event)
    }
    
    do {
      let pattern = try CHHapticPattern(events: events, parameters: [])
      let player = try engine?.makePlayer(with: pattern)
      try player?.start(atTime: 0)
    } catch {
      print("Failed to play pattern: \(error.localizedDescription)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
