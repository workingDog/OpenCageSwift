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
public class OCOptions: Codable {
    
    private var abbrv: Int?
    private var address_only: Int?
    private var add_request: Int?
    private var bounds: [Double]?
    private var countrycode: String?
    private var language: String?
    private var limit: Int?
    private var no_annotations: Int?
    private var no_dedupe: Int?
    private var no_record: Int?
    private var pretty: Int?
    private var roadinfo: Int?
    
    private var proximity: [Double]?  // <--- [lat,lon, ...]
    
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

