//
//  PullRequestViewController.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import UIKit

class PullRequestViewController: UITableViewController {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var loadMoreBtn: UIButton!
    
    
    let cellIdentifier = "PullRequestCell"
    var dataSource: [Request]
    var viewModel: PullRequestViewModel
    var urlString: String
    var pageCount: Int = 1
    
    required init?(coder: NSCoder, pullRequests: [Request], viewModel: PullRequestViewModel, urlString: String) {
        dataSource = pullRequests
        self.viewModel = viewModel
        self.urlString = urlString
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        viewModel.delegate = self
    }
    
    private func setupTable() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 192
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PullRequestCell
        cell.setup(model: dataSource[indexPath.row])
        
        return cell
    }
    
    //MARK: User actions
    
    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
        self.showAlert(message: "Select filter", forActions: [AlertAction(withTitle: "Closed", style: .default)], style: .actionSheet, callback: nil)
    }
    
    @IBAction func loadMoreTapped(_ sender: UIButton) {
        loadMoreBtn.isHidden = true
        loader.isHidden = false
        pageCount += 1
        viewModel.getPullRequest(urlString: urlString, page: String(pageCount))
    }
    
}

extension PullRequestViewController: BaseViewModelDelegate {
    
    func didReceived(pullRequests: [Request]?) {
        guard let res = pullRequests else {return}
        dataSource = dataSource + res
        
        tableView.reloadData()
        loadMoreBtn.isHidden = false
        loader.isHidden = true
    }
    
    func didError(message: String) {
        loadMoreBtn.isHidden = false
        loader.isHidden = true
    }
    
}
