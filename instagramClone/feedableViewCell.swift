//
//  feedableViewCell.swift
//  instagramClone
//
//  Created by Mürşide Gökçe on 12.03.2025.
//

import UIKit
import Firebase
import FirebaseFirestore

class feedableViewCell: UITableViewCell {

    @IBOutlet weak var documentıd: UILabel!
    @IBOutlet weak var likelabel: UILabel!
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
        let firestoredatabase = Firestore.firestore()
        if let likecount = Int(likelabel.text!){
            let likestore = ["likes": likecount+1] as [String : Any]
            firestoredatabase.collection("posts").document(documentıd.text!).setData(likestore,merge: true)
        }
    }
}
