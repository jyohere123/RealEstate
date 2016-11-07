//
//  RealEstateViewModelHelperTest.swift
//  RealEstate
//
//  Created by HM on 11/6/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import XCTest
import RxSwift

class RealEstateServiceMock: RealEstateService
{
    var realEstateModel:[RealEstateModel]
    init(realEstateModel: [RealEstateModel])
    {
        self.realEstateModel = realEstateModel
    }
    
    override func fetchRealEstateItems(completion: @escaping (Result<[RealEstateModel]>) -> Void)
    {
        completion(Result.Success(realEstateModel))
    }
    
}

class RealEstateViewModelHelperTest: XCTestCase
{
    let realEstateModel : RealEstateModel  = RealEstateModel(id : 1,
                                                            title : "Schöne Zweiraumwohnung direkt im Grünen",
                                                            price : 500,
                                                            address : "Bergmannstraße 33, 10961 Berlin",
                                                            latitude : 52.488886876519175,
                                                            longitude : 13.397688051882763,
                                                            imageURL : "https://pictureis24-a.akamaihd.net/pic/orig01/N/278/959/428/278959428-0.jpg/ORIG/resize/600x400/format/jpg")
    
    var sut : RealEstateViewModelHelper?
    let disposeBag = DisposeBag()
    
    override func setUp()
    {
        super.setUp()
        sut = RealEstateViewModelHelper()
        sut?.realEstateService = RealEstateServiceMock(realEstateModel: [realEstateModel])
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testFetchRealEstateItems()
    {
            sut?.fetchRealEstateItems().subscribe(onNext: { (realEstateItems) in
                
                XCTAssertTrue(realEstateItems.count == 1)
                XCTAssertTrue(realEstateItems[0].id == self.realEstateModel.id)
                XCTAssertTrue((realEstateItems[0].title) == self.realEstateModel.title)
                XCTAssertTrue((realEstateItems[0].price!) == " \(self.realEstateModel.price!) €")
                XCTAssertTrue((realEstateItems[0].address) == self.realEstateModel.address)
                XCTAssertTrue(realEstateItems[0].latitude == 52.488886876519175)
                XCTAssertTrue(realEstateItems[0].longitude == 13.397688051882763)
                XCTAssertTrue((realEstateItems[0].imageURL) == self.realEstateModel.imageURL)
                
            }, onError: { (error) in
                
            }, onCompleted: { 
                
                
            }, onDisposed: { 
                
                
        }).addDisposableTo(disposeBag)
    
    }
    
    
    
}
