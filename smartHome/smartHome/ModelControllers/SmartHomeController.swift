//
//  SmartHomeController.swift
//  smartHome
//
//  Created by Briana Bayne on 6/7/23.
//

import Foundation

class SmartHomeController {
    
    // MARK: - Properties
    static let shared = SmartHomeController()
    private (set) var smartHomes: [SmartHome] = []
    
    init() {
        load()
    }
    
    // MARK: - Functions
    
    func toggleAllDevicesON() {
        smartHomes.forEach { $0.isOn = true  }
        save()
    }
    
    func toggleAllDevicesOff() {
        smartHomes.forEach { $0.isOn = false}
        save()
    }
    
    func createSmartHome(name: String) {
        let smartHome = SmartHome(name:name)
        smartHomes.append(smartHome)
        save()
    }
    
    func deleteSmartHome(smartHome: SmartHome) {
        guard let index = smartHomes.firstIndex(of: smartHome) else { return }
        smartHomes.remove(at: index )
        save()
    }
    
    func toggleIsON(smartHome:SmartHome) {
        smartHome.isOn.toggle()
        save()
    }
    
    // MARK: - Persistence
    // writing
    func save() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(smartHomes)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func load() {
        guard let url = fileURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let smartHomes = try JSONDecoder().decode([SmartHome].self, from: data)
            self.smartHomes = smartHomes
        } catch {
            print(error)
        }
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = documentsDirectory.appendingPathComponent("smartHome.json")
        return url
    }
}


