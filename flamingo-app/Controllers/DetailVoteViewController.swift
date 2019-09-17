//
//  DetailVoteViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/4/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class DetailVoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    var listVote = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ĐÁNH GIÁ"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listVote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailVoteTableViewCell", for: indexPath) as! DetailVoteTableViewCell
        cell.content.text = "\(String(describing: self.listVote[indexPath.row]["Notes"]!))"
        cell.start.text = "\(String(describing: self.listVote[indexPath.row]["Star"]!))"
        cell.name.text = "\(String(describing: self.listVote[indexPath.row]["Name"]!))"
        
        var dateVote = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        if let datetime = dateFormatterGet.date(from: (self.listVote[indexPath.row]["CreatedDate"] as? String)!) {
            
            dateVote = dateFormatterPrint.string(from: datetime)
            print(dateVote)
        }
        
        cell.dateVote.text = dateVote
        cell.starVote.rating = self.listVote[indexPath.row]["Star"] as! Double
        
        return cell
    }
    
    


}
