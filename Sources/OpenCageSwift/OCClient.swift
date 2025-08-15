//
//  OCClient.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/13.
//

import Foundation

/*
 * represents an error during a connection
 */
public enum APIError: Swift.Error, LocalizedError {
    
    case unknown, apiError(reason: String), parserError(reason: String), networkError(from: URLError)
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason), .parserError(let reason):
            return reason
        case .networkError(let from):
            return from.localizedDescription
        }
    }
}

/*
 * a network connection to opencagedata API server
 * info at: https://opencagedata.com/
 * urlString: https://api.opencagedata.com/geocode/v1
 *
 *
 *
 * THIS IS NOT SECURE, THE API KEY IS EMBEDDED IN THE URL
 * RECOMMEND USING A BACKEND SERVER FOR KEY SETUP
 *
 *  see  https://opencagedata.com/faq#header-auth
 *
 */
public class OCClient {

    public var sessionManager: URLSession
    public var acceptType = "application/json; charset=utf-8"
    public var contentType = "application/json; charset=utf-8"
    
    private let openCageURL: URL?
    
    public init(apiKey: String, urlString: String, format: OCFormats) {
        let ocUrl = urlString + "/\(format.rawValue)"
        self.openCageURL = URL(string: "\(ocUrl)?key=\(apiKey)")
        self.sessionManager = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30  // seconds
            configuration.timeoutIntervalForResource = 30 // seconds
            return URLSession(configuration: configuration)
        }()
    }

    /*
     * general fetch data from the server.
     * A GET request with the chosen query is sent to the server.
     * The server response Data is returned.
     *
     * @q the query
     * @options OCOptions
     * @return Data
     */
    public func fetchDataAsyncQ(query: String, options: OCOptions) async throws -> Data {
        
        guard let url = openCageURL else {
            throw APIError.apiError(reason: "bad URL")
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = options.toQueryItems()
        queryItems.append(URLQueryItem(name: "q", value: "\(query)"))
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
  
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue(acceptType, forHTTPHeaderField: "Accept")
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
   
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknown
            }

            if (httpResponse.statusCode == 401) {
                throw APIError.apiError(reason: "Unauthorized")
            }
            if (httpResponse.statusCode == 402) {
                throw APIError.apiError(reason: "Quota exceeded")
            }
            if (httpResponse.statusCode == 403) {
                throw APIError.apiError(reason: "Resource forbidden")
            }
            if (httpResponse.statusCode == 404) {
                throw APIError.apiError(reason: "Resource not found")
            }
            if (httpResponse.statusCode == 429) {
                throw APIError.apiError(reason: "Requesting too quickly")
            }
            if (405..<500 ~= httpResponse.statusCode) {
                throw APIError.apiError(reason: "Client error")
            }
            if (500..<600 ~= httpResponse.statusCode) {
                throw APIError.apiError(reason: "Server error")
            }
            if (httpResponse.statusCode != 200) {
                throw APIError.networkError(from: URLError(.badServerResponse))
            }

            return data
        }
        catch let error as APIError {
            throw error
        }
        catch {
            throw APIError.unknown
        }
    }

    /*
     * fetch data from the server.
     * A GET request with the chosen parameters is sent to the server.
     * The server response Data is returned.
     *
     * @lat latitude
     * @lon longitude
     * @options OCOptions
     * @return Data
     */
    public func fetchDataAsync(lat: Double, lon: Double, options: OCOptions) async throws -> Data {
        try await fetchDataAsyncQ(query: "\(lat),\(lon)", options: options)
    }
    
    /*
     * fetch data from the server.
     * A GET request with the chosen parameters is sent to the server.
     * The server response Data is returned.
     *
     * @address address
     * @options OCOptions
     * @return Data
     */
    public func fetchDataAsync(address: String, options: OCOptions) async throws -> Data {
        try await fetchDataAsyncQ(query: address, options: options)
    }
    
    /*
     * fetch data from the server.
     * A GET request with the chosen parameters is sent to the server.
     * The server response is parsed then converted to a JSON object, OCResponse.
     *
     * @lat latitude
     * @lon longitude
     * @options OCOptions
     * @return a T
     */
    public func fetchJsonAsync<T: Decodable>(lat: Double, lon: Double, options: OCOptions) async throws -> T {
        let data = try await fetchDataAsync(lat: lat, lon: lon, options: options)
        let results = try JSONDecoder().decode(T.self, from: data)
        return results
    }

}
