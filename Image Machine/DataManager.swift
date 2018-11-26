//
//  DataManager.swift
//  Image Machine
//
//  Created by Juanita Vyatri on 25/11/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import Foundation
import UIKit

class Machine: NSObject, Codable {
    let machineId: String
    let machineName: String
    let machineType: String
    let QRCodeNumber: String
    let lastMaintenanceDate: Date
    let images: [String]
    
    init(machineId: String, machineName: String, machineType: String, QRCodeNumber: String, lastMaintenanceDate: Date, images: [String]) {
        self.machineId = machineId
        self.machineName = machineName
        self.machineType = machineType
        self.QRCodeNumber = QRCodeNumber
        self.lastMaintenanceDate = lastMaintenanceDate
        self.images = images
    }
}
