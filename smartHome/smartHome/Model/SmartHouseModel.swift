//
//  SmartHouseModel.swift
//  smartHome
//
//  Created by Briana Bayne on 6/7/23.
//

import Foundation

class SmartHome: Codable {
    
    let name: String
    var isOn: Bool
    let uuid: UUID
    
    init(name: String, isOn: Bool = false, uuid: UUID = UUID()) {
        self.name = name
        self.isOn = isOn
        self.uuid = uuid
    }
    
}

// MARK: - Extention
extension SmartHome: Equatable {
    static func == (lhs: SmartHome, rhs: SmartHome) -> Bool {
        return lhs.uuid == rhs.uuid
        
    }
}


