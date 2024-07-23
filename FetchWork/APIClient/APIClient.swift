//
//  APIClient.swift
//  Fetch
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import Foundation

protocol APIClientProtocol {
    
    /// Fetches all the dessets available
    /// - Returns: Dessert model
    func fetchDesserts() async throws -> Desserts
    
    /// Fetches all the data realted to a particular deset
    /// - Parameter id: Unique ID of the dessert
    /// - Returns: Detailed model related to the dessert
    func fetchMealDetails(id: String) async throws -> MealsContainer
}

struct APIClient: APIClientProtocol {
    enum APIClientError: Error {
        case badURL
    }

    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // IMP: In the production we will be breaking this into smaller and reusable peices
    func fetchDesserts() async throws -> Desserts {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw APIClientError.badURL
        }
        let desserts: Desserts = try await fetchData(from: url, as: Desserts.self)
        return desserts
    }
    
    func fetchMealDetails(id: String) async throws -> MealsContainer {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            throw APIClientError.badURL
        }
        let mealDetails: MealsContainer = try await fetchData(from: url, as: MealsContainer.self)
        return mealDetails
    }
}

extension APIClient {
    private func fetchData<T: Decodable>(from url: URL, as type: T.Type) async throws -> T {
        #if DEBUG
        if TestDetector.isRunningUITests {
            var dataToDecode: String?
            TestDetector.mockedRequest.forEach { (key: String, value: String) in
                if url.absoluteString.contains(key) {
                    dataToDecode = value
                }
            }
            if let dataToDecode {
                let decodedData = try JSONDecoder().decode(T.self, from: Data(dataToDecode.utf8))
                return decodedData
            }
        }
        #endif

        let (data, response) = try await urlSession.data(from: url, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
