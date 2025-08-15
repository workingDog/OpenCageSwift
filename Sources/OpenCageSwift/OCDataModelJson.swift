//
//  OCDataModelJson.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/15.
//
import Foundation
import SwiftUI

/**
 * access the OpenCage data using observable data model, for use in SwiftUI views
 */
@Observable public class OCDataModelJson {
    
    public var response: OCResponse = OCResponse()
    public var isLoading = false
    public var error: APIError?
    
    public let client: OCClient
    
    /// default endpoint
    public init(apiKey: String, urlString: String = "https://api.opencagedata.com/geocode/v1") {
        self.client = OCClient(apiKey: apiKey, urlString: urlString, format: .json)
    }
    
    /// get the reverse geocoding for the given location with the given options
    public func reverseGeocode(lat: Double, lon: Double, options: OCOptions) async {
        do {
            response = try await client.fetchJsonAsync(lat: lat, lon: lon, options: options)
        } catch {
            self.error = error as? APIError
            print(error)
        }
    }
    
    /// get the geocode for the given address with the given options
    public func forwardGeocode(address: String, options: OCOptions) async {
        do {
            let data = try await client.fetchDataAsync(address: address, options: options)
            response = try JSONDecoder().decode(OCResponse.self, from: data)
        }
        catch {
            self.error = error as? APIError
            print(error)
        }
    }
    
}
