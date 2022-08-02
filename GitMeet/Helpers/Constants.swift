//
//  Constant.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.github.com/repos/"
    static let endPoint = "/pulls?state=closed&page="
    
    struct Errors {
        static let invalidInput = "either username or reponame is incorrect."
        static let emptyRecord = "There is no record for %@. Please try later or some other repo"
        static let generic = "Somthing went wrong"
    }
}
