//
//  ResponseParser.swift
//  RealEstate
//
//  Created by HM on 11/1/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import SwiftyJSON

class ResponseParser: NSObject
{
    static func parseItems(json: JSON) -> [RealEstateModel]
    {
        let itemsArray = json["items"].array
        var array = Array<RealEstateModel>()
        
        for itemJson in itemsArray!
        {
            var realEstateModel = RealEstateModel()
            
            realEstateModel.id = itemJson["id"].intValue
            realEstateModel.title = itemJson["title"].stringValue
            realEstateModel.price = itemJson["price"].intValue
            realEstateModel.address = itemJson["location"]["address"].stringValue
            realEstateModel.latitude = itemJson["location"]["latitude"].doubleValue
            realEstateModel.longitude = itemJson["location"]["longitude"].doubleValue
            realEstateModel.imageURL  = itemJson["images"][0]["url"].stringValue
            
            array.append(realEstateModel)
        }
        
        return array
    }
}
