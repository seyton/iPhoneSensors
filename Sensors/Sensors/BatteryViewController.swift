//
//  BatteryViewController.swift
//  Sensors
//
//  Created by Wesley Matlock on 9/28/16.
//  Copyright © 2016 net.insoc. All rights reserved.
//

import UIKit

class BatteryViewController: UIViewController {

    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var state: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIDevice.current.isBatteryMonitoringEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(BatteryViewController.updateBatterLevel),
                                               name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BatteryViewController.updateBatteryState),
                                               name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateBatterLevel() {
    
        level.text = "\(UIDevice.current.batteryLevel)"
    }
    
    func updateBatteryState() {
        
        switch UIDevice.current.batteryState {
            
        case .full:
            state.text = "Full"
            
        case .charging:
            state.text = "Charging"
            
        case .unplugged:
            state.text = "Unplugged"
            
        case .unknown:
            state.text = "Unknown"
        }
    }
}
