//
//  Prospect.swift
//  HotProspects
//
//  Created by Bruce on 2020/5/25.
//  Copyright © 2020 JFF147. All rights reserved.
//

import Foundation

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
}
