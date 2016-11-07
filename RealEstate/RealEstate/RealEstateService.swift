//
//  RealEstateService.swift
//  RealEstate
//
//  Created by HM on 11/5/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON

enum Result<T>
{
    case Success(T)
    case Error(Error)
}

class RealEstateService: NSObject
{
    private let endPointURL = "http://private-91146-mobiletask.apiary-mock.com/realestates"
    private var request : DataRequest?

    func fetchRealEstateItems(completion: @escaping (Result<[RealEstateModel]>) -> Void)
    {
        self.request = Alamofire.request(self.endPointURL)
            .validate()
            .responseJSON { response in
                
                switch response.result
                {
                    case .success(let value):
                        let json = JSON(value)
                        let realEstateModelItems = ResponseParser.parseItems(json: json)
                        completion(Result.Success(realEstateModelItems))
                    
                    case .failure(let error):
                        print(error)
                        completion(Result.Error(error))
                }
            }
    }
    
    func cancelRequest()
    {
        if let request = self.request
        {
            request.cancel()
        }
    }
}
