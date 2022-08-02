//
//  InputViewModel.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import Foundation

protocol InputViewModelDelegate: AnyObject {
    func didReceived(pullRequests: [Request]?)
    func didError(message: String)
}

class InputViewModel {
    
    weak var delegate : InputViewModelDelegate?
    var network : Network
    
    init(netowrk: Network) {
        self.network = netowrk
    }
    
    func getPullRequest(username: String, reponame: String) {
        
        let userRepo = (username + "/" + reponame).trimmingCharacters(in: .whitespaces)
        
        if userRepo.count == 0 {
            self.delegate?.didError(message: Constants.Errors.invalidInput)
            return
        }
        
        let urlString = Constants.baseURL + userRepo + Constants.endPoint
        
        network.getData(urlString: urlString, type: Request.self) { res in
            
            DispatchQueue.main.async {
                
                switch res {
                case .success(let requests):
                    self.delegate?.didReceived(pullRequests: requests)
                    break
                case .failure(let errMsg):
                    self.delegate?.didError(message: errMsg)
                    break
                }
            }
            
        }
    }
    
}
