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

    override func viewDidDisappear(_ animated: Bool) {
        UIDevice.current.isBatteryMonitoringEnabled = false
    }
    func updateBatterLevel() {
        level.text = "\(UIDevice.current.batteryLevel)"
    }
    
    func updateBatteryState() {
        
        switch UIDevice.current.batteryState {
            
        case .full:
            state.text = "Full"
            state.backgroundColor = .green
            
        case .charging:
            state.text = "Charging"
            state.backgroundColor = .orange
            
        case .unplugged:
            state.text = "Unplugged"
            state.backgroundColor = .blue
            
        case .unknown:
            state.text = "Unknown"
            state.backgroundColor = .red
        }
    }
}
