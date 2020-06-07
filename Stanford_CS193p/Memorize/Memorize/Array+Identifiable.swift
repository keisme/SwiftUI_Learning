//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by keisme on 2020/6/7.
//  Copyright © 2020 JFF147. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
  func firstIndex(matching: Element) -> Int {
    self.firstIndex(where: { $0.id == matching.id }) ?? 0
  }
}
