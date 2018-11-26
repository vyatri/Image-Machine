//
//  MachineDataInteractor.swift
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

protocol MachineDataBusinessLogic
{
    func parseMachines(sortBy:String)
}

protocol MachineDataDataStore
{
  //var name: String { get set }
}

class MachineDataInteractor: MachineDataBusinessLogic, MachineDataDataStore
{
  var presenter: MachineDataPresentationLogic?
  var worker: MachineDataWorker?
  
  func parseMachines(sortBy:String)
  {
    worker = MachineDataWorker()
    let machines = worker?.getList(sortBy:sortBy)
    
    presenter?.presentMachines(machines: machines ?? [])
  }
}
