//
//  feedableViewCell.swift
//  instagramClone
//
//  Created by Mürşide Gökçe on 12.03.2025.
//

import UIKit

class feedableViewCell: UITableViewCell {

    @IBOutlet weak var userımage: UIImageView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var userlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func like(_ sender: Any) {
    }
}
