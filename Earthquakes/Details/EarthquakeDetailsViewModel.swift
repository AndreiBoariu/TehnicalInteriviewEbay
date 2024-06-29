//
//  EarthquakeDetailsViewModel.swift
//  Earthquakes
//
//  Created by Boariu Andy on 26.06.2024.
//

import Foundation

class EarthquakeDetailsViewModel {
    var service: EarthquakesService
    var earthquake: Earthquake?
    var error: Error?
    weak var delegate: EarthquakeDetailsViewModelDelegate?

    init(service: EarthquakesService) {
        self.service = service
    }

    func fetchEarthquakeDetails(forId id: String) {
        service.fetchEarthquakeDetails(forId: id) { [weak self] earthquake, error in
            guard let self = self else { return }

            if let error = error {
                self.error = error
                self.delegate?.didFailFetchingDetails(error: error)
            } else if let earthquake = earthquake {
                self.earthquake = earthquake
                self.delegate?.didFetchDetails(earthquake: earthquake)
            }
        }
    }
}

protocol EarthquakeDetailsViewModelDelegate: AnyObject {
    func didFetchDetails(earthquake: Earthquake)
    func didFailFetchingDetails(error: Error)
}

