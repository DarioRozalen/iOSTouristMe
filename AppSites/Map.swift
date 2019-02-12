//
//  Map.swift
//  AppSites
//
//  Created by alumnos on 12/2/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Map: UIViewController, MKMapViewDelegate{
    
    
    @IBOutlet weak var bigMap: MKMapView!
    
    override func viewDidLoad() {
        self.bigMap.delegate = self
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        for site in savedSite {
            
            let pin = MKPointAnnotation()
            
            pin.title = site.title
            pin.subtitle = site.description
            pin.coordinate.latitude = site.x_coordinate
            pin.coordinate.longitude = site.y_coordinate
            
            self.bigMap.addAnnotation(pin)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        for i in savedSite{
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(i.x_coordinate), longitude: CLLocationDegrees(i.y_coordinate))
            
            if location.latitude == view.annotation!.coordinate.latitude && location.longitude == view.annotation!.coordinate.longitude{
                let goDetail = self.storyboard?.instantiateViewController(withIdentifier: "detail")
                let destination = goDetail as! DetailSite
                
                destination.titleDetail = view.annotation?.title as! String
                destination.commentDetail = view.annotation?.subtitle as! String
                destination.x_coordinate = view.annotation?.coordinate.latitude as! Double
                destination.y_coordinate = view.annotation?.coordinate.longitude as! Double
                destination.sinceDetail = i.since
                destination.toDetail = i.to
                
                self.present(goDetail!, animated: true)
                
                
                
                
            }
        }
    }
}
