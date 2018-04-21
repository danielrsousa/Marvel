//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import XCTest

class MarvelUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     Testa se a tela de detalhes esta sendo exibida ao tocar na primeira celula da collection
     */
    func testShowDetail() {
        let app = XCUIApplication()
        
        app.collectionViews.cells.element(boundBy: 0).tap()
        
        XCTAssert(app.staticTexts["Nome:"].exists)
        XCTAssert(app.staticTexts["ID Marvel:"].exists)
    }
    
}
