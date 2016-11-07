//
//  RealEstateMapViewController.swift
//  RealEstate
//
//  Created by HM on 11/5/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import UIKit
import MapKit

class RealEstateMapViewController: UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    
    var realEstateItems: [RealEstateViewModel]?
    
    private let regionRadius: CLLocationDistance = 2000

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Real Estate Map"
        mapView.delegate = self

        if let realEstateItems = self.realEstateItems
        {
            let initialLocation = CLLocation(latitude: realEstateItems[0].latitude!, longitude:realEstateItems[0].longitude!)
            centerMapOnLocation(initialLocation)
            
            mapView.addAnnotations(realEstateItems)
        }
    }
    
    private func centerMapOnLocation(_ location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func closeMapView()
    {
        self.dismiss(animated: true, completion: nil)
    }

}

extension RealEstateMapViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? RealEstateViewModel
        {
            let identifier = "RealEstateItem"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            {
                dequeuedView.annotation = annotation
                view = dequeuedView
            }
            else
            {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let location = view.annotation as! RealEstateViewModel
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}


