//
//  EarthquakesServiceTests.swift
//  EarthquakesTests
//
//

import XCTest
@testable import Earthquakes

final class EarthquakesTests: XCTestCase {
	func testFetch() throws {
		let service = EarthquakesService()
		var earthquakes: [Earthquake] = []
		let expectation = expectation(description: "Fetched earthquakes")
		service.fetchEarthquakes { result, error in
			expectation.fulfill()
			earthquakes = result
		}
		
		wait(for: [expectation])
		
		XCTAssertEqual(earthquakes.count, 247)
		XCTAssertEqual(earthquakes.first?.title, "M 3.6 - 2 km NE of Newport Beach, CA")
	}
}
