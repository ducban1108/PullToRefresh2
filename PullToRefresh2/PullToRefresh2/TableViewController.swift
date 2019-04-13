//
//  TableViewController.swift
//  PullToRefresh2
//
//  Created by Vũ on 4/5/19.
//  Copyright © 2019 Vũ. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var spinerView: UIActivityIndicatorView!
    var number = [1, 3]
    let refresh = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refresh
        refreshControl?.tintColor = .red
        
        refresh.addTarget(self, action: #selector(reFreshData), for: .valueChanged)
    }
    @objc
    func reFreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8 ) {
            self.number = [self.number.removeFirst()]
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = "\(number[indexPath.row])"
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = number.count - 1
        if indexPath.row == lastItem {
            loadData()
            spinerView.startAnimating()
        }
    }
    func loadData() {
        let lastItem = number.last!
        let newItem = lastItem + 1
        number.append(newItem)
        tableView.reloadData()
    }
  

}
