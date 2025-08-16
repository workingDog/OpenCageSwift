//
//  OCDataModelGeojson.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/15.
//
import Foundation
import SwiftUI
import MapKit

/**
 * access the OpenCage data using observable data model, for use in SwiftUI views
 */
@Observable public class OCDataModelGeojson {
    
    public var features: [MKGeoJSONFeature] = []
    public var isLoading = false
    public var error: APIError?
    
    public let client: OCClient
    
    /// default endpoint
    public init(apiKey: String, urlString: String = "https://api.opencagedata.com/geocode/v1") {
        self.client = OCClient(apiKey: apiKey, urlString: urlString, format: .geojson)
    }
    
    /// get the reverse geocoding for the given location with the given options
    public func reverseGeocode(lat: Double, lon: Double, options: OCOptions) async {
        do {
            let data = try await client.fetchDataAsync(lat: lat, lon: lon, options: options)
            let geoJSONObjects = try MKGeoJSONDecoder().decode(data)
            features = geoJSONObjects.compactMap { $0 as? MKGeoJSONFeature }
        } catch {
            self.error = error as? APIError
            print(error)
            features = []
        }
    }
    
    /// get the geocode for the given address with the given options
    public func forwardGeocode(address: String, options: OCOptions) async {
        do {
            let data = try await client.fetchDataAsync(address: address, options: options)
            let geoJSONObjects = try MKGeoJSONDecoder().decode(data)
            features = geoJSONObjects.compactMap { $0 as? MKGeoJSONFeature }
        } catch {
            self.error = error as? APIError
            print(error)
            features = []
        }
    }
    
}


/*
 
 
 struct ContentView: View {
     let dataModel = OCDataModelGeojson(apiKey: "YOUR-KEY")

     var points: [MKPointAnnotation] {
         dataModel.features
             .flatMap { feature in
                 feature.geometry.compactMap { $0 as? MKPointAnnotation }
             }
     }
     
     var body: some View {
         VStack {
             if dataModel.isLoading {
                 ProgressView()
             }
             Map {
                 ForEach(points, id: \.self) { point in
                     Marker("Sydney", systemImage: "globe", coordinate: point.coordinate)
                 }
             }
             .mapStyle(.standard)
             .mapControlVisibility(.automatic)
         }
         .task {
             dataModel.isLoading = true
             await dataModel.forwardGeocode(address: "Sydney, Australia", options: OCOptions())
             dataModel.isLoading = false
         }
     }
   
 }
 
 */

