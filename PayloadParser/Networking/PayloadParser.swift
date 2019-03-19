//
//  PayloadParser.swift
//  PayloadParser
//
//  Created by Flamur Beqiri on 16/03/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

protocol Payload {
    func payload<T: Codable>(from data: Data?, completion: @escaping (Result<T>) -> Void)
}

class PayloadParser: Payload {
    
    func payload<T: Codable>(from data: Data?, completion: @escaping (Result<T>) -> Void) {
        guard let dataToDecode = data else {
            completion(Result.failure(BackendError.dataNotFound))
            return
        }
        do {
            let object = try JSONDecoder().decode(Response<T>.self, from: dataToDecode)
            handleResult(from: object, completion)
        } catch let error {
            #if DEBUG
            print("DEBUG: Error on decoding with: \(error)")
            #endif
            completion(Result.failure(error))
        }
    }
}

// MARK: - Helper methods

extension PayloadParser {
    
    fileprivate func handleResult<T>(from object: Response<T>, _ completion: (Result<T>) -> Void) {
        switch object.result {
        case let result as Bool:
            if result {
                handleSuccess(from: object.payload, completion)
            } else {
                handleFailure(from: object.message, completion)
            }
        case let result as String:
            if result == "true" {
                handleSuccess(from: object.payload, completion)
            } else if result == "false" {
                handleFailure(from: object.message, completion)
            } else {
                completion(Result.failure(BackendError.resultUndefined))
            }
        case let result as Int:
            if result == 1 {
                handleSuccess(from: object.payload, completion)
            } else if result == 0 {
                handleFailure(from: object.message, completion)
            } else {
                completion(Result.failure(BackendError.resultUndefined))
            }
        default:
            fatalError("Unknown object result \(object.result)")
        }
    }
    
    fileprivate func handleSuccess<T>(from payload: T?,_ completion: (Result<T>) -> Void) {
        guard let payload = payload else {
            completion(Result.failure(BackendError.payloadNotFound))
            return
        }
        completion(Result.success(payload))
    }
    
    fileprivate func handleFailure<T>(from object: String?,_ completion: (Result<T>) -> Void) {
        guard let message = object else {
            completion(Result.failure(BackendError.messageNotFound))
            return
        }
        completion(Result.failure(CustomError.runtimeError(message)))
    }
}
