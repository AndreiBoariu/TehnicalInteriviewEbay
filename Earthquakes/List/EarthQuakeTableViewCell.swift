//
//  EarthQuakeTableViewCell.swift
//  Earthquakes
//
//  
//

import UIKit

class EarthQuakeTableViewCell: UITableViewCell {
	@IBOutlet var container: UIStackView!
	@IBOutlet var title: UILabel!
	@IBOutlet var magnitude: UILabel!
	@IBOutlet var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		container.isLayoutMarginsRelativeArrangement = true
		container.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
