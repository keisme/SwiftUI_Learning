//
//  MissionView.swift
//  Moonshot
//
//  Created by Bruce on 2020/5/14.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct MissionView: View {
  let mission: Mission
  
  var body: some View {
    GeometryReader { geo in
      ScrollView(.vertical) {
        VStack {
          Image(self.mission.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: geo.size.width * 0.7)
            .padding(.top)
          
          Text(self.mission.description)
          .padding()
          
          Spacer(minLength: 25)
        }
      }
    }
    .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
  }
}

struct MissionView_Previews: PreviewProvider {
  static let missions: [Mission] = Bundle.main.decode("missions.json")

  static var previews: some View {
    MissionView(mission: missions[0])
  }
}
