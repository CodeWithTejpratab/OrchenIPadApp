//
//  LoginTest 2.swift
//  Orchen
//
//  Created by Emil Thomas Levin on 11/30/24.
//


import XCTest
@testable import Orchen

final class LoginTest: XCTestCase {

    var loginManager: LoginManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        loginManager = LoginManager()
    }

    override func tearDownWithError() throws {
        loginManager = nil
        try super.tearDownWithError()
    }
    
    func testLoginStatus_whenNotLoggedIn_shouldReturnFalse() throws {
        
        let status = loginManager.loginStatus()
   
        XCTAssertFalse(status, "Expected loginStatus to return false when no user is logged in.")
    }

    func testLoginStatus_whenLoggedIn_shouldReturnTrue() throws {
        // Simulate a logged-in user (requires mock Firebase or dependency injection)
       us = loginManager.loginStatus()
        
        XCTAssertTrue(status, "Expected loginStatus to return true when a user is logged in.")
    }
    
    func testPerformLogin_withValidCredentials_shouldNotReturnError() throws {
        let email = "test@example.com"
        let password = "validPassword123"
        let expectation = XCTestExpectation(description: "Login should succeed without errors")
        
        loginManager.performLogin(with: email, and: password) { error in
            XCTAssertNil(error, "Expected no error for valid login credentials.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSignOut_shouldUpdateLoginStatus() throws {
        let expectation = XCTestExpectation(description: "Sign out should update login status")
        var loginUpdated = false
        
        loginManager.signOut {
            loginUpdated = true
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(loginUpdated, "Expected signOut to update login status.")
    }
    
    func testGetUserID_whenLoggedIn_shouldReturnUserID() throws {
        // Simulate a logged-in user (mock Firebase)
        
        let userID = loginManager.getUserID()
        
        XCTAssertNotEqual(userID, "", "Expected a valid user ID for a logged-in user.")
    }
}
