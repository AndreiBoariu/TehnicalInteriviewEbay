//
//  Earthquake.swift
//  Earthquakes
//
//

import Foundation

// MARK: - EarthquakeResponse
struct EarthquakeResponse: Codable {
    let features: [Feature]
}

// MARK: - Feature
struct Feature: Codable {
    let id: String
    let properties: Properties
    let geometry: Geometry
}

// MARK: - Properties
struct Properties: Codable {
    let title: String
    let mag: Double
    let time: TimeInterval

    enum CodingKeys: String, CodingKey {
        case title
        case mag
        case time
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let coordinates: [Double]
}

// MARK: - Earthquake
struct Earthquake: Codable {
    let id: String
    let title: String
    let magnitude: Double
    let date: Date
    let coordinates: [Double]

    init(from feature: Feature) {
        self.id = feature.id
        self.title = feature.properties.title
        self.magnitude = feature.properties.mag
        self.date = Date(timeIntervalSince1970: feature.properties.time / 1000)
        self.coordinates = feature.geometry.coordinates
    }
}





//import Foundation
//
//class Earthquake {
//    internal init(id: String, title: String? = nil, magnitude: Double? = nil, date: Date? = nil) {
//        self.id = id
//		self.title = title
//		self.magnitude = magnitude
//		self.date = date
//	}
//	
//    let id: String
//	let title: String?
//	let magnitude: Double?
//	var date: Date?
//
//	init?(json: [String: Any]) {
//
//        guard let id = json["id"] as? String else {
//            return nil
//        }
//
//		let properties = json["properties"] as? [String: Any]
//        self.id = id
//		self.title = properties?["title"] as? String
//		self.magnitude = properties?["mag"] as? Double
//		if let timeInMilliseconds = properties?["time"] as? TimeInterval {
//			self.date = Date(timeIntervalSince1970: timeInMilliseconds / 1_000)
//		}
//	}
//}
