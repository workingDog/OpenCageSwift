//
//  OCProviderGeoJson.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/15.
//
import Foundation
import SwiftUI
import MapKit


// for testing

/**
 * provide access to the OpenCage data JSON API using simple functions
 */
public struct OCProviderGeoJson {
    
    public let client: OCClient
    
    /// default endpoint
    public init(apiKey: String, urlString: String = "https://api.opencagedata.com/geocode/v1") {
        self.client = OCClient(apiKey: apiKey, urlString: urlString, format: .geojson)
    }
    
    /// get the reverse geocoding for the given location with the given options, with async
    public func reverseGeocode(lat: Double, lon: Double, options: OCOptions) async -> [MKGeoJSONFeature] {
        do {
            let data = try await client.fetchDataAsync(lat: lat, lon: lon, options: options)
            let geoJSONObjects = try MKGeoJSONDecoder().decode(data)
            let features = geoJSONObjects.compactMap { $0 as? MKGeoJSONFeature }
            return features
        } catch {
            print(error)
            return []
        }
    }
    
    public func forwardGeocode(address: String, options: OCOptions) async throws -> [MKGeoJSONFeature] {
        do {
            let data = try await client.fetchDataAsync(address: address, options: options)

            let geoJSONObjects = try MKGeoJSONDecoder().decode(data)
            // the features
            let features = geoJSONObjects.compactMap { $0 as? MKGeoJSONFeature }

//            for feature in features {
//                // the geometry (points, lines, polygons)
//                for geometry in feature.geometry {
//                    print(geometry.coordinate)
//                }
//                // the properties (custom data)
//                if let propsData = feature.properties,
//                   let propsDict = try JSONSerialization.jsonObject(with: propsData) as? [String: Any] {
//                    print(propsDict)
//                }
//            }
            
            return features
        } catch {
            print("Failed to decode GeoJSON: \(error)")
        }
        return []
    }
    
}

