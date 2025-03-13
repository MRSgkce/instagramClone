//
//  feed.swift
//  instagramClone
//
//  Created by Mürşide Gökçe on 12.03.2025.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class feed: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
    

    @IBOutlet weak var tableview: UITableView!
    
    var userEmailarray = [String]()
    var usercommentarr = [String]()
    var likearray = [Int]()
    var userimagearray = [String]()
    var documentId = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        getData()

        // Do any additional setup after loading the view.
    }
    func getData(){
        var firestoredatabase = Firestore.firestore()
        
        firestoredatabase.collection("posts").order(by: "date", descending: true).addSnapshotListener { (snapshot,error) in
            if error != nil {
                print(error?.localizedDescription)
                
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userEmailarray.removeAll()
                    self.usercommentarr.removeAll(keepingCapacity: false)
                    self.likearray.removeAll(keepingCapacity: false)
                    self.userimagearray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentId.append(documentID)
                        
                        
                        if let postBy = document.get("postedBy") as? String {
                            self.userEmailarray.append(postBy)
                        }
                        if let postComment = document.get("postcomment") as? String {
                            self.usercommentarr.append(postComment)
                                
                            }
                        if let likes = document.get("likes") as? Int {
                            self.likearray.append(likes)
                        }
                        if let imageData = document.get("imageurl") as? String {
                            self.userimagearray.append(imageData)
                        }
                        }
                    self.tableview.reloadData()
                    }
                    
                }
            }
        }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailarray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! feedableViewCell
        
        cell.userlabel.text = userEmailarray[indexPath.row]
        cell.comment.text = usercommentarr[indexPath.row]
        
        cell.likelabel.text = String(likearray[indexPath.row])

        
        cell.userımage.sd_setImage(with: URL(string: userimagearray[indexPath.row]), placeholderImage: UIImage(named: "simpson.png"))
        cell.documentıd.text = documentId[indexPath.row]

        return cell
    }
        
    }




