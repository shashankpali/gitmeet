//
//  APIUnitTests.swift
//  GitMeetTests
//
//  Created by Shashank Pali on 08/08/22.
//

import XCTest
@testable import GitMeet

class APIUnitTests: XCTestCase {
    
    var requests : [Request]?
    var errorMsg: String = ""
    weak var expection: XCTestExpectation?
    var model = InputViewModel(netowrk: Network())
    
    override func tearDown() {
        requests = nil
        errorMsg = ""
        expection = nil
    }
    
    func test_PullRequest_With_ValidRequest_Return_Data() {
        exp(desc: "ValidRequest_Return_Data", user: "alamofire", repo: "alamofire")
        
        XCTAssertNotEqual(requests?.count, 0)
    }
    
    func test_PullRequest_With_InvalidRequest_Return_Error() {
        exp(desc: "InvalidRequest_Return_Error", user: "shashankpali", repo: "alamofire")
        
        XCTAssertNil(requests)
        XCTAssertEqual(errorMsg, "either username or reponame is incorrect.")
    }
    
    func test_PullRequest_With_ValidRequest_Return_Blank() {
        exp(desc: "ValidRequest_Return_Blank", user: "shashankpali", repo: "gitmeet")
        
        XCTAssertNotNil(requests)
        XCTAssertEqual(requests?.count, 0)
    }
    
    func exp(desc: String, user: String, repo: String) {
        
        guard let endURL = model.getEndURL(username: user, reponame: repo) else {return XCTAssert(false, "fail to create endURL")}
        
        expection = self.expectation(description: desc)
        model.delegate = self
        model.getPullRequest(urlString: endURL)
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}

extension APIUnitTests: BaseViewModelDelegate {
    
    func didReceived(pullRequests: [Request]?) {
        requests = pullRequests
        expection?.fulfill()
    }
    
    func didError(message: String) {
        errorMsg = message
        expection?.fulfill()
    }
}
