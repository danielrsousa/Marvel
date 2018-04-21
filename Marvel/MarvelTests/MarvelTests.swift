//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import XCTest
@testable import Marvel

class MarvelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     Testar se o mapper esta sendo feito de forma correta
     */
    func testMapperCharacter() {

        let mock: MockAbstractNetworking = MockAbstractNetworking()
        
        let api: CharactersAPI = CharactersAPI(networking: mock)
        
        api.getCharacters(offset: 1, success: { (response) in
            
            guard let result = response?.results else {
                XCTFail("Deve retornar um response valido")
                return
            }
            
            XCTAssertEqual(result[0].id , 1009146, "O id não é o esperado, possivel falha no mapper")
            XCTAssertEqual(result[0].name , "Abomination (Emil Blonsky)", "O nome não é o esperado, possivel falha no mapper")
            
        }) { (error) in
            XCTFail("Deve retornar um response valido")
        }
    }
    
    
}
