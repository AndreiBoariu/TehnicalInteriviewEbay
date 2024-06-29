//
//  EarthquakesTableViewController.swift
//  Earthquakes
//
//  
//

import UIKit

class EarthquakesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EarthQuakeViewModelDelegate {
	@IBOutlet var tableView: UITableView!
	@IBOutlet var countrySelector: UISegmentedControl!
	@IBOutlet var activityIndicator: UIActivityIndicatorView!
    var viewModel: EarthQuakeViewModel!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		activityIndicator.startAnimating()
		viewModel.fetch()
	}

    // MARK: - Custom Methods
    private func displayEartquackeDetails(_ id: String) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "EarthquakeDetailsVC") as! EarthquakeDetailsVC
        detailsVC.earthquakeId  = id
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    // MARK: - UITablewViewDelegate Methods
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "EarthQuakeTableViewCell", for: indexPath) as! EarthQuakeTableViewCell
		let earthquake = viewModel.earthquakes[indexPath.row]
		cell.title.text = earthquake.title
        cell.magnitude.text = "\(earthquake.magnitude)"
        cell.date.text = "\(earthquake.date)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.earthquakes.count
	}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let earthquake = viewModel.earthquakes[indexPath.row]
        displayEartquackeDetails(earthquake.id)
    }

    // MARK: - EarthQuakeViewModelDelegate Methods
	func receivedEarthquakes() {
		DispatchQueue.main.async {
			self.activityIndicator.stopAnimating()
			self.tableView.reloadData()
		}
	}
	
    // MARK: - Action Methods
	@IBAction func onCountrySelection(_ sender: UISegmentedControl) {
		activityIndicator.startAnimating()
		viewModel.fetch()
	}
}
