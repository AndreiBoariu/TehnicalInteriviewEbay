//
//  EarthQuakeViewModel.swift
//  Earthquakes
//
//

import Foundation

protocol EarthQuakeViewModelDelegate: AnyObject {
	func receivedEarthquakes()
}

class EarthQuakeViewModel {
	var service: EarthquakesService
	var earthquakes: [Earthquake] = []
	var error: Error?
	weak var delegate: EarthQuakeViewModelDelegate?

	init(service: EarthquakesService) {
		self.service = service
	}
	
	func fetch() {
		service.fetchEarthquakes() { earthquakes, error in
			self.earthquakes = earthquakes
			self.delegate?.receivedEarthquakes()
		}
	}
}
