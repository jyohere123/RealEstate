//
//  FavoriteManagerTest.swift
//  RealEstate
//
//  Created by HM on 11/7/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import XCTest

class FavoriteManagerTest: XCTestCase {
    
    var sut : FavoritesDelegate?
    
    override func setUp()
    {
        super.setUp()
        sut = FavoritesManager.sharedManager
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testFavoriteItem()
    {
        var itemID = 1000
        sut?.favoriteItemWithID(id: itemID)
        var isFavoriteItem = sut?.isFavoriteItem(id: itemID)
        XCTAssertTrue(isFavoriteItem == true)
        
        itemID = 1001
        isFavoriteItem = sut?.isFavoriteItem(id: 1001)
        XCTAssertTrue(isFavoriteItem == false)
    }
  
    
    func testUnFavoriteItem()
    {
        let itemID = 1000
        sut?.unFavoriteItemWithID(id: itemID)
        let isFavoriteItem = sut?.isFavoriteItem(id: itemID)
        XCTAssertTrue(isFavoriteItem == false)
    }
    
}
