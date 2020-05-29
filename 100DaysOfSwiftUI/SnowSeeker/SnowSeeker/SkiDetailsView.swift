//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Bruce on 2020/5/29.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct SkiDetailsView: View {
  let resort: Resort
  
  var body: some View {
    Group {
      Text("Elevation: \(resort.elevation)m").layoutPriority(1)
      Spacer().frame(height: 0)
      Text("Snow: \(resort.snowDepth)cm").layoutPriority(1)
    }
  }
}
