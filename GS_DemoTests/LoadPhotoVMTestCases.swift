//
//  LoadPhotoVMTestCases.swift
//  GS_DemoTests
//
//  Created by Nikunj Joshi on 24/07/22.
//

import XCTest
@testable import GS_Demo

class LoadPhotoVMTestCases: XCTestCase {
    
    var sut: PhotoViewModel!
    
    override func setUp() {
        super.setUp()
        sut = PhotoViewModel()
    }
    
    func testLoadPhoto() {
        let refreshExp = self.expectation(description: "refreshExpecation")
        refreshExp.assertForOverFulfill = false
        sut.refreshUI = {
            refreshExp.fulfill()
        }
        
        let toggleExp = self.expectation(description: "toggleExpecatation")
        toggleExp.assertForOverFulfill = false
        sut.toggleLoadingStatus = { loading, msg in
            toggleExp.fulfill()
        }
        
        sut.pictureDetails = mockedPicData
        
        wait(for: [refreshExp, toggleExp], timeout: 5.0)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
