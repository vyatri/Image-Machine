//
//  MachineHomeWorker.swift
//  Image Machine
//
//  Created by Juanita Vyatri on 24/11/18.
//  Copyright (c) 2018 Vyatri. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class MachineHomeWorker
{
    func getData(machineQR: String) -> String
    {
        var foundId = ""
        if let data = UserDefaults.standard.data(forKey: "machines") {
            let machines = try! PropertyListDecoder().decode([Machine].self, from: data)
            machines.forEach { (_machine) in
                if _machine.QRCodeNumber == machineQR {
                    foundId = _machine.machineId
                }
            }
        }
        return foundId
    }
}
