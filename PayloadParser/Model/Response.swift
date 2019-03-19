//
//  Response.swift
//  PayloadParser
//
//  Created by Flamur Beqiri on 16/03/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
    let result: T
    let payload: T?
    let message: String?
}
