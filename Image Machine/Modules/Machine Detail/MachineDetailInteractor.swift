//
//  MachineDetailInteractor.swift
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

protocol MachineDetailBusinessLogic
{
    func fetchMachine(machineId: String)
    func addMachine(newMachine:Machine)
    func updateMachine(machine: Machine)
    func removeMachine(machineId: String)
}

protocol MachineDetailDataStore
{
    var machineId: String! { get set}
    var displayMode: String? { get set}
}

class MachineDetailInteractor: MachineDetailBusinessLogic, MachineDetailDataStore
{
    
    var machineId: String!
    var displayMode: String?
    
    var presenter: MachineDetailPresentationLogic?
    var worker: MachineDetailWorker?
    
    func fetchMachine(machineId: String)
    {
        worker = MachineDetailWorker()
        let machine = worker?.getData(machineId: machineId)
        
        presenter?.presentMachine(machine: machine!)
    }
    
    func addMachine(newMachine: Machine) {
        worker = MachineDetailWorker()
        let _add: Bool = worker?.addMachine(newMachine) ?? false
        if (_add) {
            presenter?.actionCompleted()
        } else {
            presenter?.actionFailed(msg: "Unable to add new machine")
        }
    }
    
    func updateMachine(machine: Machine) {
        worker = MachineDetailWorker()
        let _update: Bool = worker?.updateMachine(machine) ?? false
        if (_update) {
            presenter?.actionCompleted()
        } else {
            presenter?.actionFailed(msg: "Unable to update machine")
        }
    }
    
    func removeMachine(machineId: String) {
        worker = MachineDetailWorker()
        let _remove: Bool = worker?.removeMachine(machineId: machineId) ?? false
        if (_remove) {
            presenter?.actionCompleted()
        } else {
            presenter?.actionFailed(msg: "Unable to remove machine")
        }
    }
}
