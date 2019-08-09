//
//  ResponseParser.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case unknown
    case parsing
    case connection
    case httpError(code: Int)
}

class ResponseParser {
    
    func parseError(response: URLResponse?, error: Error?) -> ServiceError? {
        if let error = error as NSError? {
            if error.domain == "NSURLErrorDomain", error.code == -1009 {
                return .connection
            }
            return .unknown
        }
        
        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            return .httpError(code: response.statusCode)
        }
        
        return nil
    }
    
    func parseData<T>(type: T.Type, data: Data?, strategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) -> Result<T, ServiceError> where T: Codable {
        if type == Void.self {
            let t = () as! T
            return .success(t)
        }
        
        guard let data = data else {
            return .failure(.parsing)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = strategy
            
            let result = try decoder.decode(T.self, from: data)
            
            return .success(result)
        } catch {
            print("JSON error: \(error.localizedDescription)")
            return .failure(.parsing)
        }
    }

    func parse<T>(
        type: T.Type,
        data: Data?,
        strategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        response: URLResponse?,
        error: Error?) -> Result<T, ServiceError> where T: Codable {
        
        if let serverError = self.parseError(response: response, error: error) {
            return .failure(serverError)
        }
        
        return self.parseData(type: type, data: data, strategy: strategy)
    }
    
}
