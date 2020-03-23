//
//  MarvelMVVMTests.swift
//  MarvelMVVMTests
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import XCTest
@testable import MarvelMVVM

extension XCTestCase {
    enum Timeout {
        static var value = 30.0
    }
}

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    let stub = Stub(fileName: "characters", status: .success)
    lazy var api: ApiMock = {
        return ApiMock(stub: self.stub)
    }()
    
    override func setUp() {
        let service = CharactersApi(api: api)
        viewModel = HomeViewModel(service: service)
    }

    func testFetchCharacterByNameWithSuccess() {
        let expectation = self.expectation(description: "Fetching characters")
        
        viewModel.fetchBy("Spider Man") { [weak self] in
            guard let self = self else { return }
            XCTAssert(self.viewModel.characteres.count == 20)
            XCTAssert(self.viewModel.shoudShowHeader())
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: Timeout.value, handler: nil)
    }
    
    func testClearFilter() {
        let expectation = self.expectation(description: "Fetching characters")
        
        viewModel.fetchBy("Spider Man") { [weak self] in
            guard let self = self else { return }
            XCTAssert(self.viewModel.characteres.count == 20)
            XCTAssert(self.viewModel.shoudShowHeader())
            self.viewModel.clearFilter()
            XCTAssert(self.viewModel.characteres.isEmpty)
            XCTAssertFalse(self.viewModel.shoudShowHeader())
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: Timeout.value, handler: nil)
    }
    
    func testVariableFoundAnyCharacter() {
        let expectation = self.expectation(description: "Fetching characters")
        
        viewModel.fetchBy("Spider Man") { [weak self] in
            guard let self = self else { return }
            XCTAssert(self.viewModel.foundAnyCharacter)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: Timeout.value, handler: nil)
    }
    
    func testSearchText() {
        let expectation = self.expectation(description: "Fetching characters")
        
        viewModel.fetchBy("Spider Man") { [weak self] in
            guard let self = self else { return }
            XCTAssert(self.viewModel.searchText == "Spider Man")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: Timeout.value, handler: nil)
    }
    
    func testUpdateOffSet() {
        let expectation = self.expectation(description: "Fetching characters")
        
        viewModel.fetchBy("Spider Man") { [weak self] in
            guard let self = self else { return }
            XCTAssert(self.viewModel.offSet == 20)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: Timeout.value, handler: nil)
    }
    
    func testFetchStateEqualNone() {
        let expectation = self.expectation(description: "Fetching characters")
        
        viewModel.fetchBy("Spider Man") { [weak self] in
            guard let self = self else { return }
            XCTAssert(self.viewModel.fetchState == .none)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: Timeout.value, handler: nil)
    }
    
    func testFetchStateEqualGenericError() {
        api.stub = Stub(fileName: "empty", status: .failure)
        let expectation = self.expectation(description: "Fetching characters")
        
        viewModel.fetchBy("Spider Man") { [weak self] in
            guard let self = self else { return }
            XCTAssert(self.viewModel.fetchState == .genericError)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: Timeout.value, handler: nil)
    }
    
    func testFetchStateEqualEmptyState() {
        api.stub = Stub(fileName: "result_empty", status: .success)
        let expectation = self.expectation(description: "Fetching characters")
        
        viewModel.fetchBy("Spider Man") { [weak self] in
            guard let self = self else { return }
            XCTAssert(self.viewModel.fetchState == .emptyState)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: Timeout.value, handler: nil)
    }
}
