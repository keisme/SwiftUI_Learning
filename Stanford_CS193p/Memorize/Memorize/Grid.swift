//
//  Grid.swift
//  Memorize
//
//  Created by keisme on 2020/6/7.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
  var items: [Item]
  var viewForItem: (Item) -> ItemView
  
  init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
    self.items = items
    self.viewForItem = viewForItem
  }
  
  var body: some View {
    GeometryReader { geo in
      self.body(for: GridLayout(itemCount: self.items.count, in: geo.size))
    }
  }
  
  func body(for layout: GridLayout) -> some View {
    ForEach(items) { item in
      self.body(for: item, in: layout)
    }
  }
  
  func body(for item: Item, in layout: GridLayout) -> some View {
    let index = self.items.firstIndex(matching: item)
    return viewForItem(item)
      .frame(width: layout.itemSize.width, height: layout.itemSize.height)
      .position(layout.location(ofItemAt: index))
  }
}
