//
//  URLValidationUnitTests.swift
//  GitMeetTests
//
//  Created by Shashank Pali on 08/08/22.
//

import XCTest
@testable import GitMeet

class URLValidationUnitTests: XCTestCase {

    func test_UrlValidation_With_EmptyUsername_Returns_Failure() {
        let model1 = InputViewModel(netowrk: Network())
        let urlStr = model1.getEndURL(username: "", reponame: "asd")
        XCTAssertEqual(urlStr, nil)
    }
    
    func test_UrlValidation_With_EmptyReponame_Returns_Failure() {
        let model1 = InputViewModel(netowrk: Network())
        let urlStr = model1.getEndURL(username: "asd", reponame: "")
        XCTAssertEqual(urlStr, nil)
    }
    
    func test_UrlValidation_With_Username_And_Reponame_Returns_Success() {
        let model1 = InputViewModel(netowrk: Network())
        let urlStr = model1.getEndURL(username: "asd", reponame: "qwe")
        XCTAssertNotEqual(urlStr?.count, 0)
    }

}
