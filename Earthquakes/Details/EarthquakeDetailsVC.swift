//
//  EarthquakeDetailsVC.swift
//  Earthquakes
//
//  Created by Boariu Andy on 26.06.2024.
//

import Foundation
import UIKit

class EarthquakeDetailsVC: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var magnitudeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var earthquakeId: String = ""
    var viewModel: EarthquakeDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = EarthquakeDetailsViewModel(service: EarthquakesService())
        viewModel.delegate = self
        fetchEarthquakeDetails()
    }

    func fetchEarthquakeDetails() {
        activityIndicator.startAnimating()
        viewModel.fetchEarthquakeDetails(forId: earthquakeId)
    }

    func updateUI(with earthquake: Earthquake) {
        titleLabel.text = earthquake.title
        // Assuming earthquake.location is a CLLocationCoordinate2D, you would update the map view here
        //locationLabel.text = "\(earthquake.location.latitude), \(earthquake.location.longitude)"
        magnitudeLabel.text = "\(earthquake.magnitude)"
        dateLabel.text = "\(earthquake.date)"
    }
}

extension EarthquakeDetailsVC: EarthquakeDetailsViewModelDelegate {
    func didFetchDetails(earthquake: Earthquake) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.updateUI(with: earthquake)
        }
    }

    func didFailFetchingDetails(error: Error) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            // Handle error display
            print("Error fetching earthquake details:", error.localizedDescription)
        }
    }
}
