//
//  URLSession.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import Foundation

protocol URLSessionProtocol {
    
    /// Retrieves the contents of a URL and delivers the data asynchronously.
    /// - Parameters:
    ///   - url: The URL to retrieve.
    ///   - delegate: A delegate that receives life cycle and authentication challenge callbacks as the transfer progresses.
    /// - Returns: An asynchronously-delivered tuple that contains the URL contents as a Data instance, and a URLResponse.
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
