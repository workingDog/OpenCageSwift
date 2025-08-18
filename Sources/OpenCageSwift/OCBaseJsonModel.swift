//
//  OCBaseJsonModel.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/18.
//
import Foundation
import SwiftUI

/**
 * provide access to the OpenCage data observable data for use in SwiftUI views
 */
@Observable
@MainActor
public class OCBaseJsonModel {
    
    public var isLoading = false
    public var error: APIError?
    
    public let client: OCClient
    
    /// default endpoint
    public init(apiKey: String, urlString: String = "https://api.opencagedata.com/geocode/v1") {
        self.client = OCClient(apiKey: apiKey, urlString: urlString, format: .json)
    }

    /// get the reverse geocoding for the given location with the given options, return a OCResponse
    public func getReverseGeocode(lat: Double, lng: Double, options: OCOptions) async -> OCResponse {
        do {
            let data = try await client.fetchDataAsync(lat: lat, lng: lng, options: options)
            let response: OCResponse = try JSONDecoder().decode(OCResponse.self, from: data)
            return response
        } catch {
            self.error = error as? APIError
            print(error)
            return OCResponse()
        }
    }
    
    /// get the geocode for the given address with the given options, return a OCResponse
    public func getForwardGeocode(address: String, options: OCOptions) async -> OCResponse {
        do {
            let data = try await client.fetchDataAsync(address: address, options: options)
            let response: OCResponse = try JSONDecoder().decode(OCResponse.self, from: data)
            return response
        } catch {
            self.error = error as? APIError
            print(error)
            return OCResponse()
        }
    }
    
}
