//
//  GithubService.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

final class GithubService: GithubServiceProtocol {
    
    // MARK: - Public Properties
    
    let baseURL: URL
    let session: URLSession
    let completionQueue: DispatchQueue
    
    // MARK: - Endpoints
    
    enum Endpoints: String {
        case searchRepositories = "/search/repositories"
        case languages = "/repos/%@/%@/languages"
        case readme = "/repos/%@/%@/readme"
    }
    
    // MARK: - Initializers
    
    init(baseURL: URL = ApiConstants.githubBaseURL, session: URLSession = .shared, completionQueue: DispatchQueue = .main) {
        self.baseURL = baseURL
        self.session = session
        self.completionQueue = completionQueue
    }
    
    // MARK: - GithubServiceProtocol
    
    func searchRepositories(
        q: String,
        sort: RepositorySearch.Sort = .bestMatch,
        order: RepositorySearch.Order = .descending,
        completion: ((Result<RepositorySearchResponse, ServiceError>) -> Void)? = nil) -> Cancelable {
        
        let url = self.baseURL.appendingPathComponent(Endpoints.searchRepositories.rawValue)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "sort", value: sort.rawValue),
            URLQueryItem(name: "order", value: order.rawValue)
        ]
        
        let reusltURL = urlComponents.url!
        let task = self.session.dataTask(with: reusltURL) { [weak self] (data, response, error) in
            let result = ResponseParser().parse(
                type: RepositorySearchResponse.self,
                data: data,
                response: response,
                error: error)
            
            self?.completionQueue.async {
                completion?(result)
            }
        }
        
        task.resume()
        
        return task
    }
    
    func languages(
        owner: String,
        repo: String,
        completion: ((Result<[Language], ServiceError>) -> Void)? = nil) -> Cancelable  {
        
        let endpoint = String(format: Endpoints.languages.rawValue, arguments: [owner, repo])
        let reusltURL = self.baseURL.appendingPathComponent(endpoint)
        
        let task = self.session.dataTask(with: reusltURL) {  [weak self] (data, response, error) in
            if let error = ResponseParser().parseError(response: response, error: error) {
                self?.completionQueue.async { completion?(.failure(error)) }
                return
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Int] {
                let languages = Language.parse(dictionary: json)
                self?.completionQueue.async { completion?(.success(languages)) }
            } else {
                self?.completionQueue.async { completion?(.failure(.parsing)) }
            }
        }
        
        task.resume()
        
        return task
    }
    
    func readme(
        owner: String,
        repo: String,
        completion: ((Result<Readme?, ServiceError>) -> Void)? = nil) -> Cancelable {
        
        let endpoint = String(format: Endpoints.readme.rawValue, arguments: [owner, repo])
        let reusltURL = self.baseURL.appendingPathComponent(endpoint)
        
        let task = self.session.dataTask(with: reusltURL) {  [weak self] (data, response, error) in
            if let error = ResponseParser().parseError(response: response, error: error) {
                switch error {
                case .httpError(let code):
                    if code == 404 {
                        self?.completionQueue.async { completion?(.success(nil)) }
                    } else {
                        fallthrough
                    }
                default:
                    self?.completionQueue.async { completion?(.failure(error)) }
                }
                return
            }
            
            let result = ResponseParser().parseData(type: Readme.self, data: data)
            
            self?.completionQueue.async {
                switch result {
                case .success(let readme):
                    completion?(.success(readme))
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
        
        return task
    }
    
}
