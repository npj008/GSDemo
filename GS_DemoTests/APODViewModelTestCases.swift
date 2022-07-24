//
//  APODViewModelTestCases.swift
//  GS_DemoTests
//
//  Created by Nikunj Joshi on 24/07/22.
//

import XCTest
@testable import GS_Demo

let mockedPicData = PictureDetails(date: "mocked", explanation: "mocked explaination", hdurl: "mockURLHD", mediaType: "image", serviceVersion: "mock", title: "test image", url: "file///")

class APODViewModelTestCases: XCTestCase {
    
    var sut: APODViewModel!
    var mockCoreData: MockCoreData!
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockCoreData = MockCoreData()
        mockService = MockAPIService()
        sut = APODViewModel(coreDataService: mockCoreData, apiService: mockService)
    }
    
    func testInitialise() {
        sut.initialise()
        XCTAssertTrue(sut.allCellVMs.isEmpty)
    }
    
    func testSeachMode() {
        sut.setCurrentMode(mode: .search(date: Date()))
        sleep(3)
        XCTAssertNotNil(sut.selectedDate, #function)
        XCTAssertTrue(mockService.fetchAPODCalled, #function)
        XCTAssertTrue(mockCoreData.saveAPODDataCalled, #function)
    }
    
    func testFavoriteMode() {
        sut.setCurrentMode(mode: .favorite)
        sleep(3)
        XCTAssertTrue(self.mockCoreData.fetchFavoriteCalled, #function)
        XCTAssertTrue(sut.allCellVMs.count == 1, #function)
        let pic = sut.getCellViewModel(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(pic.post.title == mockedPicData.title, #function)
        XCTAssertTrue(pic.post.isFavorite == mockedPicData.isFavorite, #function)
        pic.post.isFavorite.toggle()
        XCTAssertTrue(pic.post.isFavorite == !mockedPicData.isFavorite, #function)
        
        let exp = XCTestExpectation(description: "toggle favorite")
        sut.toggleFavorite(isFavorite: true, postDetail: pic.post) { success in
            XCTAssertTrue(self.mockCoreData.toggleFavoriteCalled, #function)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3.0)
    }
    
    override func tearDown() {
        sut = nil
        mockCoreData = nil
        mockService = nil
        super.tearDown()
    }
   
}

class MockCoreData: CoreDataManagerEntity {
    var saveAPODDataCalled = false
    var toggleFavoriteCalled = false
    var fetchFavoriteCalled = false

    func saveAPODData(postDetail: PictureDetails) -> PictureDetails? {
        saveAPODDataCalled = true
        return nil
    }
    
    func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void)) {
        toggleFavoriteCalled = true
        completion(toggleFavoriteCalled)
    }
    
    func getAllRecentPosts(_ sortedByDate: Bool, sortAscending: Bool) -> [PictureDetails] {
        return [mockedPicData]
    }
    
    func retriveFavouriteAPOD(_ sortedByDate: Bool, sortAscending: Bool) -> [PictureDetails] {
        fetchFavoriteCalled = true
        return [mockedPicData]
    }
}

class MockAPIService: GSAPIServiceEntity {
    var fetchAPODCalled = false
    func fetchAPODDetails(date: Date, completion: @escaping (GSAPIServiceResult<PictureDetails>) -> Void) {
        fetchAPODCalled = true
        completion(.success(mockedPicData))
    }
}
