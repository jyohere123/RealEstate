//
//  RealEstateViewModelHelper.swift
//  RealEstate
//
//  Created by HM on 11/5/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

class RealEstateViewModelHelper: NSObject
{
    var realEstateService = RealEstateService()
    var realEstateViewModelItems : [RealEstateViewModel]? = nil
    
    func fetchRealEstateItems() -> Observable<[RealEstateViewModel]>
    {
        return Observable.create { observer in
            
            self.realEstateService.fetchRealEstateItems(completion: { (result) in
                
                switch result
                {
                    case .Success(let realEstateModelItems):
                        
                        self.realEstateViewModelItems = realEstateModelItems.map{ (realEstateModelItem) -> RealEstateViewModel in
                        
                            let viewModel = RealEstateViewModel()
                            viewModel.map(realEstateModel: realEstateModelItem as RealEstateModel)
                            return viewModel
                        }
                        observer.onNext(self.realEstateViewModelItems!)
                        observer.onCompleted()
                    
                    case .Error(let error):
                        observer.onError(error)
                }
            })
            
            let cancel = Disposables.create {
                self.realEstateService.cancelRequest()
            }
            return cancel
        }
    }
}
