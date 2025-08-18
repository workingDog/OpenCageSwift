//
//  OCBatchProvider.swift
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
public final class OCBatchProvider {

    public var batchResponses: [OCResponse] = []
    public var isLoading = false
    public var error: APIError?
    
    public let client: OCClient
    
    /// default endpoint
    public init(apiKey: String, urlString: String = "https://api.opencagedata.com/geocode/v1") {
        self.client = OCClient(apiKey: apiKey, urlString: urlString, format: .json)
    }

    /// get the batch/concurrent reverse geocoding for the given locations with the given options
    public func batchReverseGeocode(_ coords: [Geometry], options: OCOptions) async  {
        return await withTaskGroup(of: OCResponse.self) { group -> Void in
            for coord in coords {
                group.addTask {
                    await self.getReverseGeocode(lat: coord.lat, lng: coord.lng, options: options)
                }
            }
            for await response in group {
                batchResponses.append(response)
            }
        }
    }

    /// get the batch/concurrent forward geocoding for the given addresses with the given options
    public func batchForwardGeocode(_ addresses: [String], options: OCOptions) async  {
        return await withTaskGroup(of: OCResponse.self) { group -> Void in
            for address in addresses {
                group.addTask {
                    await self.getForwardGeocode(address: address, options: options)
                }
            }
            for await response in group {
                batchResponses.append(response)
            }
        }
    }
    
    /// get the reverse geocoding for the given location with the given options, return a OCResponse
    private func getReverseGeocode(lat: Double, lng: Double, options: OCOptions) async -> OCResponse {
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
    private func getForwardGeocode(address: String, options: OCOptions) async -> OCResponse {
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



