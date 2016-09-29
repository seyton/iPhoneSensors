//
//  SpeedViewController.swift
//  Sensors
//
//  Created by Wesley Matlock on 9/28/16.
//  Copyright © 2016 net.insoc. All rights reserved.
//

import UIKit
import CoreLocation

class SpeedViewController: UIViewController {

    @IBOutlet weak var metersPerSecond: UILabel!
    @IBOutlet weak var kilometersPerSecond: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var altitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    
    fileprivate var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
            locationManager.headingFilter = kCLHeadingFilterNone
            locationManager.headingOrientation = .portrait
            locationManager.startUpdatingHeading()
        }
    }


    override func viewDidDisappear(_ animated: Bool) {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
            locationManager.stopUpdatingHeading()
        }
    }
}

extension SpeedViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            break
            
        case.authorizedWhenInUse, .authorizedAlways:
            break
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     
        print("--First Location \(locations.first)")
        
        if let newestLocation = locations.last {
            metersPerSecond.text = String().appendingFormat("%.2f", (newestLocation.speed))
            kilometersPerSecond.text = String().appendingFormat("%.2f", (newestLocation.speed) * 3.6)
            altitude.text = String().appendingFormat("%.2f m", (newestLocation.altitude))
            longitude.text = String().appendingFormat("%.4f", (newestLocation.coordinate.longitude))
            latitude.text = String().appendingFormat("%.4f", (newestLocation.coordinate.latitude))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading.text = String().appendingFormat("%.2f", newHeading.magneticHeading)
    }
}
