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
    
    fileprivate var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }


    override func viewDidDisappear(_ animated: Bool) {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
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
        
        if let newestLocation = locations.last {
            metersPerSecond.text = String().appendingFormat("%.2f", (newestLocation.speed))
            kilometersPerSecond.text = String().appendingFormat("%.2f", (newestLocation.speed) * 3.6)
        }
    }
}
