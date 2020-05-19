//
//  Result.swift
//  BucketList
//
//  Created by Bruce on 2020/5/19.
//  Copyright © 2020 JFF147. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
