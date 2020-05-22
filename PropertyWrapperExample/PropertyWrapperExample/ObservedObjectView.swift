//
//  ObservedObjectView.swift
//  PropertyWrapperExample
//
//  Created by Bruce on 2020/5/20.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

class Person: ObservableObject {
  @Published var name: String
  @Published var age: Int
  
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

struct EditView: View {
  @ObservedObject var person: Person
  
  var body: some View {
    // TextField 只能绑定 String，需要自定义 Binding
    let bindingAge = Binding<String>(get: {
      "\(self.person.age)" == "0" ? "" : "\(self.person.age)"
    }) { value in
      self.person.age = Int(value) ?? 0
    }
    return Form {
      TextField("Input name", text: $person.name)
      TextField("Input age", text: bindingAge)
    }
  }
}

struct ObservedObjectView: View {
  @ObservedObject private var person = Person(name: "Bruce", age: 30)
  
  var body: some View {
    List {
      Text(person.name)
      Text("\(person.age)")
    }
    .navigationBarTitle("Person", displayMode: .inline)
    .navigationBarItems(trailing:
      NavigationLink(destination: EditView(person: self.person)) {
        Text("Edit")
      }
    )
  }
}

struct ObservedObjectView_Previews: PreviewProvider {
  static var previews: some View {
    ObservedObjectView()
  }
}
