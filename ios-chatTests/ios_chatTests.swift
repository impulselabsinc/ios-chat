//
//  ios_chatTests.swift
//  ios-chatTests
//
//  Created by Nikhil Prabhakar on 7/19/17.
//  Copyright © 2017 Impulse Labs. All rights reserved.
//

import XCTest
@testable import ios_chat

class ios_chatTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as! ViewController
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(viewController.view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUIElementsExist(){
        XCTAssertNotNil(viewController.loginMessage)
        XCTAssertNotNil(viewController.navBar)
        XCTAssertNotNil(viewController.signInButton)
        XCTAssertNotNil(viewController.signOutButton)
    }
    
    func testViewControllerLoginMessageNotLoggedIn() {
        XCTAssertTrue(viewController.loginMessage.text == "You are not logged in")
    }
    
}
