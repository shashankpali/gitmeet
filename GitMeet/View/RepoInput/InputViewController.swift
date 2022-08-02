//
//  ViewController.swift
//  GitMeet
//
//  Created by Shashank Pali on 01/08/22.
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var reponameField: UITextField!
    @IBOutlet weak var fetchBtn: UIButton!
    
    var viewModel = InputViewModel.init(netowrk: Network())
    
    override func viewDidLoad() {
        viewModel.delegate = self
    }
    
    //MARK: User actions
    
    @IBAction func fetchBtnTapped(_ sender: UIButton) {
        getPullRequests()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField == reponameField else { return reponameField.becomeFirstResponder()}
        getPullRequests()
        return true
    }
    
    //MARK: Helper methods
    
    private func getPullRequests() {
        if usernameField.text?.count == 0 && reponameField.text?.count == 0 {
            usernameField.becomeFirstResponder()
            return
        }
        self.view.endEditing(true)
        fetchBtn.isHidden = true
        
        viewModel.getPullRequest(username: usernameField.text!, reponame: reponameField.text!)
    }
}

extension InputViewController: InputViewModelDelegate {
    
    func didReceived(pullRequests: [Request]?) {
        print(pullRequests)
    }
    
    func didError(message: String) {
        
    }
}
