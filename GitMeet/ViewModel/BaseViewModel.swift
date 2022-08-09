//
//  BaseViewModel.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import Foundation

protocol BaseViewModelDelegate: AnyObject {
    func didReceived(pullRequests: [Request]?)
    func didError(message: String)
}

class BaseViewModel {
    
    weak var delegate : BaseViewModelDelegate?
    var network : Network
    
    init(netowrk: Network) {
        self.network = netowrk
    }
    
    func getEndURL(username: String, reponame: String) -> String? {
        let user = username.trimmingCharacters(in: .whitespaces)
        let repo = reponame.trimmingCharacters(in: .whitespaces)
        
        guard user.count != 0 && repo.count != 0 else {return nil}
        
        return Constants.baseURL + user + "/" + repo + Constants.endPoint
    }
    
    func getPullRequest(urlString: String, page: String = "1") {
        
        network.getData(urlString: urlString + page) { res in
            
            DispatchQueue.main.async {
                
                switch res {
                case .success(let data):
                    if let requests = self.network.parse(data: data, type: Request.self) {
                        self.delegate?.didReceived(pullRequests: requests)
                        return
                    }
                    self.delegate?.didError(message: Constants.Errors.generic)
                    break
                case .failure(let errMsg):
                    self.delegate?.didError(message: errMsg)
                    break
                }
            }
            
        }
    }
    
}
