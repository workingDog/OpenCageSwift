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
public final class OCBatchProvider: OCBaseJsonModel {
    
    public var batchResponses: [OCResponse] = []
    
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
    
}
