//
//  SmartHomeTableViewCell.swift
//  smartHome
//
//  Created by Briana Bayne on 6/7/23.
//

import UIKit

// MARK: - Protocol


protocol SmartHomeTablewViewCellDelegate: AnyObject {
    func smartHomeSwitch(cell: SmartHomeTableViewCell)
}

class SmartHomeTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var smartHomeSwitch: UISwitch!
    
    // MARK: - Properties
    weak var delegate: SmartHomeTablewViewCellDelegate?
    
    // MARK: - Functions
    func updateUI(smartHome: SmartHome) {
        deviceNameLabel.text = smartHome.name
        smartHomeSwitch.isOn = smartHome.isOn
        
    }
    
    
    // MARK: - Actions
    @IBAction func smartHomeSwitch(_ sender: Any) {
        delegate?.smartHomeSwitch(cell: self)
    }
}
