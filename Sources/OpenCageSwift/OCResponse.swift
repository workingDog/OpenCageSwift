//
//  OCResponse.swift
//  OpenCageSwift
//
//  Created by Ringo Wathelet on 2025/08/13.
//

import Foundation
import CoreLocation


// MARK: - OCResponse
public struct OCResponse: Identifiable, Codable, Sendable {
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
        self.status = Status(code: 0, message: "")
        self.stayInformed = StayInformed(blog: "", mastodon: "")
        self.thanks = ""
        self.timestamp = OCTimestamp()
        self.totalResults = 0
    }
}

// MARK: - License
public struct License: Identifiable, Codable, Sendable {
    public let id = UUID()
    
    public let name: String
    public let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - Rate
public struct Rate: Codable, Sendable {
    public let limit, remaining, reset: Int
    
    public init(limit: Int, remaining: Int, reset: Int) {
        self.limit = limit
        self.remaining = remaining
        self.reset = reset
    }
}

// MARK: - Result
public struct Result: Identifiable, Codable, Sendable {
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
    
    public init(annotations: Annotations? = nil, bounds: Bounds? = nil, components: Components? = nil, confidence: Int? = nil, distanceFromQ: DistanceFromQ? = nil, formatted: String? = nil, geometry: Geometry? = nil) {
        self.annotations = annotations
        self.bounds = bounds
        self.components = components
        self.formatted = formatted
        self.geometry = geometry
        self.confidence = confidence
        self.distanceFromQ = distanceFromQ
    }
}

// MARK: - Annotations
public struct Annotations: Codable, Sendable {
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
    public let timezone: OCTimezone?
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
    
    public init(dms: Dms?, mgrs: String?, maidenhead: String?, mercator: Mercator?, osm: Osm?, unM49: UnM49?, callingcode: Int?, currency: Currency?, flag: String?, geohash: String?, qibla: Double?, roadinfo: Roadinfo?, sun: Sun?, timezone: OCTimezone?, what3Words: What3Words?) {
        self.dms = dms
        self.mgrs = mgrs
        self.maidenhead = maidenhead
        self.mercator = mercator
        self.osm = osm
        self.unM49 = unM49
        self.callingcode = callingcode
        self.currency = currency
        self.flag = flag
        self.geohash = geohash
        self.qibla = qibla
        self.roadinfo = roadinfo
        self.sun = sun
        self.timezone = timezone
        self.what3Words = what3Words
    }
    
}

// MARK: - Currency
public struct Currency: Codable, Sendable {
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
    
    public init(alternateSymbols: [String]?, decimalMark: String?, disambiguateSymbol: String?, format: String?, htmlEntity: String?, isoCode: String?, isoNumeric: String?, name: String?, smallestDenomination: Int?, subunit: String?, subunitToUnit: Int?, symbol: String?, symbolFirst: Int?, thousandsSeparator: String?) {
        self.alternateSymbols = alternateSymbols
        self.decimalMark = decimalMark
        self.disambiguateSymbol = disambiguateSymbol
        self.format = format
        self.htmlEntity = htmlEntity
        self.isoCode = isoCode
        self.isoNumeric = isoNumeric
        self.name = name
        self.smallestDenomination = smallestDenomination
        self.subunit = subunit
        self.subunitToUnit = subunitToUnit
        self.symbol = symbol
        self.symbolFirst = symbolFirst
        self.thousandsSeparator = thousandsSeparator
    }

}

// MARK: - Dms
public struct Dms: Codable, Sendable {
    public let lat, lng: String
    
    public init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
}

// MARK: - Mercator
public struct Mercator: Codable, Sendable {
    public let x, y: Double
    
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

// MARK: - Osm
public struct Osm: Codable, Sendable {
    public let editURL, noteURL, url: String?

    enum CodingKeys: String, CodingKey {
        case url
        case editURL = "edit_url"
        case noteURL = "note_url"
    }
    
    public init(editURL: String, noteURL: String, url: String) {
        self.editURL = editURL
        self.noteURL = noteURL
        self.url = url
    }
}

// MARK: - Roadinfo
public struct Roadinfo: Codable, Sendable {
    public let driveOn, road, roadType, speedIn: String?

    enum CodingKeys: String, CodingKey {
        case road
        case driveOn = "drive_on"
        case roadType = "road_type"
        case speedIn = "speed_in"
    }
    
    public init(driveOn: String?, road: String?, roadType: String?, speedIn: String?) {
        self.driveOn = driveOn
        self.road = road
        self.roadType = roadType
        self.speedIn = speedIn
    }
}

// MARK: - Sun
public struct Sun: Codable, Sendable {
    public let rise, sunSet: Rise

    enum CodingKeys: String, CodingKey {
        case rise
        case sunSet = "set"
    }
    
    public init(rise: Rise, sunSet: Rise) {
        self.rise = rise
        self.sunSet = sunSet
    }
}

// MARK: - Rise
public struct Rise: Codable, Sendable {
    public let apparent, astronomical, civil, nautical: Int
    
    public init(apparent: Int, astronomical: Int, civil: Int, nautical: Int) {
        self.apparent = apparent
        self.astronomical = astronomical
        self.civil = civil
        self.nautical = nautical
    }
}

// MARK: - OCTimezone
public struct OCTimezone: Codable, Sendable {
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
    
    public init(name: String, nowInDst: Int, offsetSEC: Int, offsetString: String, shortName: String) {
        self.name = name
        self.nowInDst = nowInDst
        self.offsetSEC = offsetSEC
        self.offsetString = offsetString
        self.shortName = shortName
    }
    
    /// Convert to Foundation.TimeZone
    public var asTimeZone: TimeZone? {
        // Prefer identifier first (handles DST properly)
        if let tz = TimeZone(identifier: name) {
            return tz
        }
        // Fallback: construct from raw offset
        return TimeZone(secondsFromGMT: offsetSEC)
    }
}

// MARK: - UnM49
public struct UnM49: Codable, Sendable {
    public let regions: Regions
    public let statisticalGroupings: [String]

    enum CodingKeys: String, CodingKey {
        case regions
        case statisticalGroupings = "statistical_groupings"
    }
    
    public init(regions: Regions, statisticalGroupings: [String]) {
        self.regions = regions
        self.statisticalGroupings = statisticalGroupings
    }
}

// MARK: - Regions
public struct Regions: Codable, Sendable {
    public let africa, na, southernAfrica, subSaharanAfrica: String?
    public let world: String?

    enum CodingKeys: String, CodingKey {
        case africa = "AFRICA"
        case na = "NA"
        case southernAfrica = "SOUTHERN_AFRICA"
        case subSaharanAfrica = "SUB-SAHARAN_AFRICA"
        case world = "WORLD"
    }
    
    public init(africa: String?, na: String?, southernAfrica: String?, subSaharanAfrica: String?, world: String?) {
        self.africa = africa
        self.na = na
        self.southernAfrica = southernAfrica
        self.subSaharanAfrica = subSaharanAfrica
        self.world = world
    }
}

// MARK: - What3Words
public struct What3Words: Codable, Sendable {
    public let words: String
    
    public init(words: String) {
        self.words = words
    }
}

// MARK: - Bounds
public struct Bounds: Codable, Sendable {
    public let northeast, southwest: Geometry
    
    public init(northeast: Geometry, southwest: Geometry) {
        self.northeast = northeast
        self.southwest = southwest
    }
}

// MARK: - Geometry
public struct Geometry: Codable, Sendable {
    public let lat, lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    public func asCoordinate() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}

// MARK: - Components
public struct Components: Codable, Sendable {
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
    
    public init(iso31661_Alpha2: String?, iso31661_Alpha3: String?, iso31662: [String]?, category: String?, normalizedCity: String?, type: String?, city: String?, continent: String?, country: String?, countryCode: String?, postcode: String?, road: String?, roadType: String?, state: String?, suburb: String?) {
        self.iso31661_Alpha2 = iso31661_Alpha2
        self.iso31661_Alpha3 = iso31661_Alpha3
        self.iso31662 = iso31662
        self.category = category
        self.normalizedCity = normalizedCity
        self.type = type
        self.city = city
        self.continent = continent
        self.country = country
        self.countryCode = countryCode
        self.postcode = postcode
        self.road = road
        self.roadType = roadType
        self.state = state
        self.suburb = suburb
    }
}

// MARK: - DistanceFromQ
public struct DistanceFromQ: Codable, Sendable {
    public let meters: Int
    
    public init(meters: Int) {
        self.meters = meters
    }
}

// MARK: - Status
public struct Status: Codable, Sendable {
    public let code: Int
    public let message: String
    
    public init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

// MARK: - StayInformed
public struct StayInformed: Codable, Sendable {
    public let blog, mastodon: String
    
    public init(blog: String, mastodon: String) {
        self.blog = blog
        self.mastodon = mastodon
    }
}

// MARK: - OCTimestamp
public struct OCTimestamp: Codable, Sendable {
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
    
    public func asDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(createdUnix))
    }
}
