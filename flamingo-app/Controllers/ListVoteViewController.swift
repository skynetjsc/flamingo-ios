//
//  DetailVoteViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/4/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class ListVoteViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segementedVote: UISegmentedControl!
    var listVote = [[String: Any]]()
    let segmentGrayColor = UIColor(red: 0.889415, green: 0.889436, blue:0.889424, alpha: 1.0 )
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupSegemented()
//        self.getListVote()
        if segementedVote.selectedSegmentIndex == 0 {
            self.getListVote("1")
        }
        if segementedVote.selectedSegmentIndex == 1 {
            self.getListVote("2")
        }
    }
    
    func setupSegemented() {
        segementedVote.backgroundColor = .clear
        segementedVote.tintColor = .clear
        
        segementedVote.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
            ], for: .normal)
        
        segementedVote.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.orange
            ], for: .selected)
        
        segementedVote.layer.borderWidth = 1
        segementedVote.layer.borderColor = segmentGrayColor.cgColor
        segementedVote.layer.masksToBounds = true
        
//        for (index,element) in segementedVote.subviews.enumerated() {
//            element.addBorder(toSide: .Left, withColor: segmentGrayColor.cgColor, andThickness: 1, height: 50)
//        }
        
        segementedVote.selectedSegmentIndex = 0
    }
    
    @IBAction func segementValueChange(_ sender: Any) {
        if segementedVote.selectedSegmentIndex == 0 {
            self.getListVote("1")
        }
        if segementedVote.selectedSegmentIndex == 1 {
            self.getListVote("2")
        }
        
    }
    
    
    
    func getListVote(_ status: String) {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "Username": currentUser["LoginName"],
            "Status": status
            ] as [String : Any]
        self.showProgress()
        BaseService.shared.geListRate(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            print(response)
            if status {
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        
                        if let result = response["Data"] as? [[String: Any]] {
                            self.listVote = result
                            
                        }
                        self.tableView.reloadData()
                        
                    })
                    
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listVote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailVoteTableViewCell", for: indexPath) as! DetailVoteTableViewCell
        cell.content.text = "\(String(describing: self.listVote[indexPath.row]["Notes"]!))"
        cell.start.text = "\(String(describing: self.listVote[indexPath.row]["Star"]!))"
        if !String(describing: self.listVote[indexPath.row]["Name"]!).elementsEqual("<null>") {
                cell.name.text = "\(String(describing: self.listVote[indexPath.row]["Name"]!))"
        } else {
            cell.name.text = " "
        }
        
        
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
