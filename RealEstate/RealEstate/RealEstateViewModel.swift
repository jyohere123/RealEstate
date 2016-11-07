//
//  RealEstateViewModel.swift
//  RealEstate
//
//  Created by HM on 11/1/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import MapKit
import Contacts

class RealEstateViewModel : NSObject, MKAnnotation
{
    var id : Int?
    var title : String?
    var price : String?
    var address : String?
    var latitude : Double?
    var longitude : Double?
    var imageURL : String?
    
    func map(realEstateModel : RealEstateModel)
    {
        self.id = realEstateModel.id
        self.title = realEstateModel.title
        self.price = " \(realEstateModel.price!) €"
        self.address = realEstateModel.address
        self.latitude = realEstateModel.latitude
        self.longitude = realEstateModel.longitude
        self.imageURL = realEstateModel.imageURL
    }
    
    var coordinate: CLLocationCoordinate2D
    {
        return CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
    }
    
    var subtitle: String?
    {
        return self.address
    }
    
    func mapItem() -> MKMapItem
    {
        let addressDict = [CNPostalAddressStreetKey: title!]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title!
        
        return mapItem
    }
    
   
}
