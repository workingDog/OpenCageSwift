//
//  OCResponse.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/13.
//

import Foundation


// MARK: - OCResponse
public struct OCResponse: Identifiable, Codable {
    public let id = UUID()
     
    public let documentation: String
    public let licenses: [License]
    public let rate: Rate?
    public let results: [Result]
    public let status: Status
    public let stayInformed: StayInformed
    public let thanks: String
    public let timestamp: OCTimestamp
    public let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case documentation, licenses, rate, results, status, thanks, timestamp
        case stayInformed = "stay_informed"
        case totalResults = "total_results"
    }
    
    public init(documentation: String, licenses: [License], rate: Rate?, results: [Result], status: Status, stayInformed: StayInformed, thanks: String, timestamp: OCTimestamp, totalResults: Int) {
        self.documentation = documentation
        self.licenses = licenses
        self.rate = rate
        self.results = results
        self.status = status
        self.stayInformed = stayInformed
        self.thanks = thanks
        self.timestamp = timestamp
        self.totalResults = totalResults
    }
    
    public init() {
        self.documentation = ""
        self.licenses = []
        self.rate = nil
        self.results = []
        self.status = Status(code: 200, message: "OK")
        self.stayInformed = StayInformed(blog: "", mastodon: "")
        self.thanks = ""
        self.timestamp = OCTimestamp()
        self.totalResults = 0
    }
}

// MARK: - License
public struct License: Identifiable, Codable {
    public let id = UUID()
    
    public let name: String
    public let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
}

// MARK: - Rate
public struct Rate: Codable {
    public let limit, remaining, reset: Int
}

// MARK: - Result
public struct Result: Identifiable, Codable {
    public let id = UUID()
    
    public let annotations: Annotations?
    public let bounds: Bounds?
    public let components: Components?
    public let confidence: Int?
    public let distanceFromQ: DistanceFromQ?
    public let formatted: String?
    public let geometry: Geometry?

    enum CodingKeys: String, CodingKey {
        case annotations, bounds, components, confidence, formatted, geometry
        case distanceFromQ = "distance_from_q"
    }
}

// MARK: - Annotations
public struct Annotations: Codable {
    public let dms: Dms?
    public let mgrs, maidenhead: String?
    public let mercator: Mercator?
    public let osm: Osm?
    public let unM49: UnM49?
    public let callingcode: Int?
    public let currency: Currency?
    public let flag, geohash: String?
    public let qibla: Double?
    public let roadinfo: Roadinfo?
    public let sun: Sun?
    public let timezone: Timezone?
    public let what3Words: What3Words?

    enum CodingKeys: String, CodingKey {
        case callingcode, currency, flag, geohash, qibla, roadinfo, sun, timezone
        case dms = "DMS"
        case mgrs = "MGRS"
        case maidenhead = "Maidenhead"
        case mercator = "Mercator"
        case osm = "OSM"
        case unM49 = "UN_M49"
        case what3Words = "what3words"
    }
}

// MARK: - Currency
public struct Currency: Codable {
    public let alternateSymbols: [String]?
    public let decimalMark, disambiguateSymbol, format, htmlEntity: String?
    public let isoCode, isoNumeric, name: String?
    public let smallestDenomination: Int?
    public let subunit: String?
    public let subunitToUnit: Int?
    public let symbol: String?
    public let symbolFirst: Int?
    public let thousandsSeparator: String?

    enum CodingKeys: String, CodingKey {
        case format, name, subunit, symbol
        case alternateSymbols = "alternate_symbols"
        case decimalMark = "decimal_mark"
        case disambiguateSymbol = "disambiguate_symbol"
        case htmlEntity = "html_entity"
        case isoCode = "iso_code"
        case isoNumeric = "iso_numeric"
        case smallestDenomination = "smallest_denomination"
        case subunitToUnit = "subunit_to_unit"
        case symbolFirst = "symbol_first"
        case thousandsSeparator = "thousands_separator"
    }
}

// MARK: - Dms
public struct Dms: Codable {
    public let lat, lng: String
}

// MARK: - Mercator
public struct Mercator: Codable {
    public let x, y: Double
}

// MARK: - Osm
public struct Osm: Codable {
    public let editURL, noteURL, url: String

    enum CodingKeys: String, CodingKey {
        case url
        case editURL = "edit_url"
        case noteURL = "note_url"
    }
}

// MARK: - Roadinfo
public struct Roadinfo: Codable {
    public let driveOn, road, roadType, speedIn: String?

    enum CodingKeys: String, CodingKey {
        case road
        case driveOn = "drive_on"
        case roadType = "road_type"
        case speedIn = "speed_in"
    }
}

// MARK: - Sun
public struct Sun: Codable {
    public let rise, sunSet: Rise

    enum CodingKeys: String, CodingKey {
        case rise
        case sunSet = "set"
    }
}

// MARK: - Rise
public struct Rise: Codable {
    public let apparent, astronomical, civil, nautical: Int
}

// MARK: - Timezone
public struct Timezone: Codable {
    public let name: String
    public let nowInDst, offsetSEC: Int
    public let offsetString, shortName: String

    enum CodingKeys: String, CodingKey {
        case name
        case nowInDst = "now_in_dst"
        case offsetSEC = "offset_sec"
        case offsetString = "offset_string"
        case shortName = "short_name"
    }
}

// MARK: - UnM49
public struct UnM49: Codable {
    public let regions: Regions
    public let statisticalGroupings: [String]

    enum CodingKeys: String, CodingKey {
        case regions
        case statisticalGroupings = "statistical_groupings"
    }
}

// MARK: - Regions
public struct Regions: Codable {
    public let africa, na, southernAfrica, subSaharanAfrica: String?
    public let world: String?

    enum CodingKeys: String, CodingKey {
        case africa = "AFRICA"
        case na = "NA"
        case southernAfrica = "SOUTHERN_AFRICA"
        case subSaharanAfrica = "SUB-SAHARAN_AFRICA"
        case world = "WORLD"
    }
}

// MARK: - What3Words
public struct What3Words: Codable {
    public let words: String
}

// MARK: - Bounds
public struct Bounds: Codable {
    public let northeast, southwest: Geometry
}

// MARK: - Geometry
public struct Geometry: Codable {
    public let lat, lng: Double
}

// MARK: - Components
public struct Components: Codable {
    public let iso31661_Alpha2, iso31661_Alpha3: String?
    public let iso31662: [String]?
    public let category, normalizedCity, type, city: String?
    public let continent, country, countryCode, postcode: String?
    public let road, roadType, state, suburb: String?

    enum CodingKeys: String, CodingKey {
        case city, continent, country, postcode, road, state, suburb
        case iso31661_Alpha2 = "ISO_3166-1_alpha-2"
        case iso31661_Alpha3 = "ISO_3166-1_alpha-3"
        case iso31662 = "ISO_3166-2"
        case category = "_category"
        case normalizedCity = "_normalized_city"
        case type = "_type"
        case countryCode = "country_code"
        case roadType = "road_type"
    }
}

// MARK: - DistanceFromQ
public struct DistanceFromQ: Codable {
    public let meters: Int
}

// MARK: - Status
public struct Status: Codable {
    public let code: Int
    public let message: String
}

// MARK: - StayInformed
public struct StayInformed: Codable {
    public let blog, mastodon: String
}

// MARK: - OCTimestamp
public struct OCTimestamp: Codable {
    public let createdHTTP: String
    public let createdUnix: Int

    enum CodingKeys: String, CodingKey {
        case createdHTTP = "created_http"
        case createdUnix = "created_unix"
    }
    
    public init(createdHTTP: String, createdUnix: Int) {
        self.createdHTTP = createdHTTP
        self.createdUnix = createdUnix
    }
    
    public init() {
        self.createdHTTP = ""
        self.createdUnix = 0
    }
}
