//
//  PullRequestViewController.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import UIKit

class PullRequestViewController: UITableViewController {
    
    var dataSource: [Request]
    
    required init?(coder: NSCoder, pullRequests: [Request]) {
        dataSource = pullRequests
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataSource)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
}
