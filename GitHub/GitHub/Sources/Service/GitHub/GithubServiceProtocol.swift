//
//  GithubServiceProtocol.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

protocol GithubServiceProtocol {
    
    /// Method for searching repositories.
    ///
    /// - Parameters:
    ///   - q: The input search string.
    ///   - sort: The sort rules.
    ///   - order: The order priority.
    ///   - completion: The completion block.
    /// - Returns: The object that can be canceled.
    @discardableResult
    func searchRepositories(
        q: String,
        sort: RepositorySearch.Sort,
        order: RepositorySearch.Order,
        completion: ((Result<RepositorySearchResponse, ServiceError>) -> Void)?) -> Cancelable
    
    /// Method return all languages used in repository
    ///
    /// - Parameters:
    ///   - owner: The repository owner name
    ///   - repo:  The repository name
    ///   - completion: The completion block.
    /// - Returns: The object that can be canceled.
    @discardableResult
    func languages(
        owner: String,
        repo: String,
        completion: ((Result<[Language], ServiceError>) -> Void)?) -> Cancelable
    
    @discardableResult
    /// Method return readme for repository
    ///
    /// - Parameters:
    ///   - owner: The repository owner name
    ///   - repo:  The repository name
    ///   - completion: The completion block.
    /// - Returns: The object that can be canceled.
    func readme(
        owner: String,
        repo: String,
        completion: ((Result<Readme?, ServiceError>) -> Void)?) -> Cancelable
    
}
