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
    var urlString : String?
    
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
        urlString = viewModel.getEndURL(username: usernameField.text!, reponame: reponameField.text!)
        guard urlString?.count != 0 else {return}
        viewModel.getPullRequest(urlString: urlString!)
    }
}

extension InputViewController: BaseViewModelDelegate {
    
    func didReceived(pullRequests: [Request]?) {
        if pullRequests?.count == 0 {
            let errMsg = String(format: Constants.Errors.emptyRecord, (usernameField.text! + "/" + reponameField.text!))
            self.showAlert(title: "Oopss!!", message: errMsg, forActions: [AlertAction(withTitle: "Ok", style: .default)])
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let pRController = storyboard.instantiateViewController(identifier: "PullRequestViewController") { [unowned self] coder in
                let model = PullRequestViewModel.init(netowrk: Network())
               return PullRequestViewController(coder: coder, pullRequests: pullRequests!, viewModel: model, urlString: urlString!) }
            
            self.navigationController?.pushViewController(pRController, animated: true)
        }
        fetchBtn.isHidden = false
    }
    
    func didError(message: String) {
        self.showAlert(title: "Error", message: message, forActions: [AlertAction(withTitle: "Ok", style: .default)])
        fetchBtn.isHidden = false
    }
}
