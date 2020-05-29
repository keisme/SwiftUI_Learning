//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Bruce on 2020/5/29.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
  private var resorts: Set<String>
  private let saveKey = "Favorites"
  
  init() {
    if let savedArr = UserDefaults.standard.value(forKey: saveKey) as? [String] {
      self.resorts = Set(savedArr)
      return
    }
    self.resorts = []
  }
  
  func contains(_ resort: Resort) -> Bool {
    resorts.contains(resort.id)
  }
  
  func add(_ resort: Resort) {
    objectWillChange.send()
    resorts.insert(resort.id)
    save()
  }
  
  func remove(_ resort: Resort) {
    objectWillChange.send()
    resorts.remove(resort.id)
    save()
  }
  
  func save() {
    let arr = Array(resorts)
    UserDefaults.standard.set(arr, forKey: saveKey)
  }
}
