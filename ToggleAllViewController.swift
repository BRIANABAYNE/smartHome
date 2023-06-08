//
//  ToggleAllViewController.swift
//  smartHome
//
//  Created by Briana Bayne on 6/8/23.
//

import UIKit

class ToggleAllViewController: UIViewController {

        // MARK: - Actions
    @IBAction func turnAllOnButtonTapped(_ sender: Any) {
         NotificationCenter.default.post(name: Constants.Notifications.turnAllOn, object: nil)
    }
    @IBAction func TurnAllOffButtonTapped(_ sender: Any) {
         NotificationCenter.default.post(name: Constants.Notifications.turnAllOff, object: nil)
    }
    
}
