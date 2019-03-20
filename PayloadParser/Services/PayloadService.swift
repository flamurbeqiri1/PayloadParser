//
//  PayloadService.swift
//  PayloadParser
//
//  Created by Flamur Beqiri on 20/03/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

protocol PayloadService {
    func payload<T: Codable>(from data: Data?, completion: @escaping (Result<T>) -> Void)
}
