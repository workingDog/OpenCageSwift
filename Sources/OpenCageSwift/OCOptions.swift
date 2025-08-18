//
//  OCOptions.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/13.
//
import Foundation


/*
 * Response format types
 */
public enum OCFormats: String, Identifiable, CaseIterable {
    public var id: String {
        return self.rawValue
    }
    case json
    case geojson
    case xml
    case googleJson = "google-v3-json"
}

/*
 * Options
 */
public struct OCOptions: Codable, Sendable {
    
    public var abbrv: Int?
    public var address_only: Int?
    public var add_request: Int?
    public var bounds: [Double]?
    public var countrycode: String?
    public var language: String?
    public var limit: Int?
    public var no_annotations: Int?
    public var no_dedupe: Int?
    public var no_record: Int?
    public var pretty: Int?
    public var roadinfo: Int?
    
    public var proximity: [Double]?  // <--- [lat,lon, ...]
    
    public init(abbrv: Int? = nil, address_only: Int? = nil, add_request: Int? = nil, bounds: [Double]? = nil, countrycode: String? = nil, language: String? = nil, limit: Int? = nil, no_annotations: Int? = nil, no_dedupe: Int? = nil, no_record: Int? = nil, pretty: Int? = nil, roadinfo: Int? = nil, proximity: [Double]? = nil) {
        self.abbrv = abbrv
        self.address_only = address_only
        self.add_request = add_request
        self.bounds = bounds
        self.countrycode = countrycode
        self.language = language
        self.limit = limit
        self.no_annotations = no_annotations
        self.no_dedupe = no_dedupe
        self.no_record = no_record
        self.pretty = pretty
        self.roadinfo = roadinfo
        self.proximity = proximity
    }
    
    public func toQueryItems() -> [URLQueryItem] {
        guard let data = try? JSONEncoder().encode(self),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return []
        }
        return dict.compactMap { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
    }
}

