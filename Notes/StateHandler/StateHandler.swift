//
//  error_handler.swift
//  Notes
//
//  Created by Inyene Etoedia on 09/05/2023.
//

import Foundation

enum ResultState<T: Equatable & Hashable>: LocalizedError {
    case loading
    case idle
    case success(T)
    case failure(Error)
    case failedToDecode(error: Error)
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    var error: Error? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    var isFailure: Bool {
        if case .failure = self {
            return true
        }
        return false
    }
}

extension ResultState {
    var errorDescription: String? {
        
        switch self  {
        case .failedToDecode(let error):
            return "failed to decode \(error.localizedDescription)"
        case .failure(let err):
            return "An Error occured: \(err.localizedDescription)"
        case.success(let success):
            return "Result: \(success)"
        default:
            return "Unknown"
        }
        
    }
}
