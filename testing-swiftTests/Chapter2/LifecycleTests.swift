//
//  LifecycleTests.swift
//  testing-swiftTests
//
//  Created by Anthony Benitez-Rodriguez on 7/23/23.
//

import Foundation

import XCTest

class LifecycleTests: XCTestCase {
    override class func setUp() {
        print("In class setUp.")
    }
    
    override class func tearDown() {
        print("In class tearDown.")
    }
    
    override func setUp() {
        print("In setUp.")
    }
    
    override func tearDown() {
        print("In tearDown.")
    }
    
    func testExample() {
        print("Starting test.")
        
        addTeardownBlock {
            print("In first tearDown block.")
        }
        
        print("In middle of test.")
        
        addTeardownBlock {
            print("In second tearDown block.")
        }
        
        print("Finishing test.")
    }
}
