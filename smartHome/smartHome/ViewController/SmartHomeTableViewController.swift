//
//  SmartHomeTableViewController.swift
//  smartHome
//
//  Created by Briana Bayne on 6/7/23.
//

import UIKit

class SmartHomeTableViewController: UITableViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SmartHomeController.shared.smartHomes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "smartHomeCell", for: indexPath) as?
                SmartHomeTableViewCell else { return UITableViewCell() }
        
        let smartHome = SmartHomeController.shared.smartHomes[indexPath.row]
        cell.updateUI(smartHome: smartHome)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let smartHome = SmartHomeController.shared.smartHomes[indexPath.row]
            SmartHomeController.shared.deleteSmartHome(smartHome: smartHome)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    // MARK: - Functions
    
    @objc func turnAllOn() {
        SmartHomeController.shared.toggleAllDevicesON()
        tableView.reloadData()
    }
    @objc func turnAllOff() {
        SmartHomeController.shared.toggleAllDevicesOff()
        tableView.reloadData()
    }
    
    func notificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(turnAllOn), name: Constants.Notifications.turnAllOn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(turnAllOff), name: Constants.Notifications.turnAllOff,object: nil)
    }
    
    // MARK: - Alert
    
    func presentAddNewDeviceAlert() {
        let alert = UIAlertController(title:"New Device", message: "Enter the name of your Device below", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = " Your message here..."
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
        let confirmAction = UIAlertAction(title: "Post", style: .default) { _ in
            guard let textField = alert.textFields?.first,
                  let smartDeviceName = textField.text else { return }
            SmartHomeController.shared.createSmartHome(name: smartDeviceName)
            self.tableView.reloadData()
        }
        
        alert.addAction(dismissAction)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
    
    // MARK: - Action
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAddNewDeviceAlert()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

// MARK: - Extension
extension SmartHomeTableViewController: SmartHomeTablewViewCellDelegate {
    func smartHomeSwitch(cell: SmartHomeTableViewCell) {
        guard let indexPath = tableView.indexPath(for:cell ) else { return }
        let smartHome = SmartHomeController.shared.smartHomes[indexPath.row]
        SmartHomeController.shared.toggleIsON(smartHome: smartHome)
        cell.updateUI(smartHome: smartHome)
    }
}
