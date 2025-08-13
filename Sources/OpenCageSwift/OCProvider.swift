//
//  OCProvider.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/13.
//
import Foundation
import SwiftUI


/**
 * provide access to the OpenCage data JSON API using simple functions 
 */
public struct OCProviderJson {
    
    public let client: OCClient
    
    /// default endpoint
    public init(apiKey: String, urlString: String = "https://api.opencagedata.com/geocode/v1") {
        self.client = OCClient(apiKey: apiKey, urlString: urlString, format: .json)
    }
    
    /// get the reverse geocoding for the given location with the given options, with async
    public func reverseGeocode(lat: Double, lon: Double, options: OCOptions) async -> OCResponse? {
        do {
            let results: OCResponse = try await client.fetchJsonAsync(lat: lat, lon: lon, options: options)
            return results
        } catch {
            print(error)
            return nil
        }
    }
    
    /// get the reverse geocoding of the given location
    /// with the given options, results pass back through the binding
    @MainActor
    public func reverseGeocode(lat: Double, lon: Double, response: Binding<OCResponse>, options: OCOptions) {
        reverseGeocode(lat: lat, lon: lon, options: options) { results in
            if let results {
                response.wrappedValue = results
            }
        }
    }
    
    /// get the reverse geocoding for the given location with the given options, with completion handler
    @MainActor
    public func reverseGeocode(lat: Double, lon: Double, options: OCOptions, completion: @escaping (OCResponse?) -> Void) {
        Task {
            let results: OCResponse? = await reverseGeocode(lat: lat, lon: lon, options: options)
            DispatchQueue.main.async {
                completion(results)
            }
        }
    }
    
    /// get the geocode for the given address with the given options
    public func forwardGeocode(address: String, options: OCOptions) async throws -> OCResponse? {
        do {
            let data = try await client.fetchDataAsync(address: address, options: options)
            return try JSONDecoder().decode(OCResponse.self, from: data)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    /// get the geocode for the given address with the given options, with completion handler
    @MainActor
    public func forwardGeocode(address: String, options: OCOptions, completion: @escaping (OCResponse?) -> Void) {
        Task {
            let results: OCResponse? = try await forwardGeocode(address: address, options: options)
            DispatchQueue.main.async {
                completion(results)
            }
        }
    }

}

