//
//  CustomError.swift
//  PayloadParser
//
//  Created by Flamur Beqiri on 16/03/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case runtimeError(String)
}

enum BackendError: String {
    case dataNotFound = "Data not found"
    case payloadNotFound = "Payload not found"
    case messageNotFound = "Message not found"
    case resultUndefined = "Result is undefined"
}

extension BackendError: LocalizedError {
    public var errorDescription: String? {
        return rawValue
    }
}
