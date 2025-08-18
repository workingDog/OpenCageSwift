//
//  OCDataModelJson.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/15.
//


import Foundation
import SwiftUI

/**
 * provide access to the OpenCage data observable data for use in SwiftUI views
 */
@Observable
@MainActor
public final class OCDataModelJson: OCBaseJsonModel {
    
    public var response: OCResponse = OCResponse()
    
    /// get the reverse geocoding for the given location with the given options
    public func reverseGeocode(lat: Double, lng: Double, options: OCOptions) async {
        response = await getReverseGeocode(lat: lat, lng: lng, options: options)
    }
    
    /// get the reverse geocoding for the given location with the given options
    public func reverseGeocode(geometry: Geometry, options: OCOptions) async {
        await reverseGeocode(lat: geometry.lat, lng: geometry.lng, options: options)
    }
    
    /// get the geocode for the given address with the given options
    public func forwardGeocode(address: String, options: OCOptions) async {
        response = await getForwardGeocode(address: address, options: options)
    }
    
}
