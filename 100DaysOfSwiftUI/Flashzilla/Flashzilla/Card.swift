//
//  Card.swift
//  Flashzilla
//
//  Created by keisme on 2020/5/28.
//  Copyright © 2020 JFF147. All rights reserved.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String

    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
