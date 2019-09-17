//
//  ListNewsViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class ListNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listNews = [[String: Any]]()
    var data = [String: Any]()

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(listNews)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.listNews.count)
        return self.listNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListNewsTableViewCell") as! ListNewsTableViewCell
        
        cell.imageNews.downloaded(from: (self.listNews[indexPath.row]["Picture1"]  as? String)!)
        cell.imageNews.contentMode = .scaleAspectFill
        cell.dateNews.text = ""
//        cell.subtitle.text = self.listNews[indexPath.row]["Content"] as? String
        cell.title.text = self.listNews[indexPath.row]["Title"] as? String
        do {
            let attrStr = try NSAttributedString(
                data: String((self.listNews[indexPath.row]["Content"] as? String)!).data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ .documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            cell.subtitle.attributedText = attrStr
        } catch let error {
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.data = self.listNews[indexPath.row]
        self.performSegue(withIdentifier: "DetailNews", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailNews" {
            if let viewController: DetailNewsViewController = segue.destination as? DetailNewsViewController {
                viewController.data = self.data
            }
        }
    }


}
