//
//  MachineDetailPresenter.swift
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

protocol MachineDetailPresentationLogic
{
    func presentMachine(machine: Machine)
    func actionCompleted()
    func actionFailed(msg: String)
}

class MachineDetailPresenter: MachineDetailPresentationLogic
{
    weak var viewController: MachineDetailDisplayLogic?
    
    // MARK: Do something
    
    func presentMachine(machine: Machine)
    {
        viewController?.displayMachine(machine: machine)
    }
    
    func actionCompleted() {
        viewController?.actionCompletedAndLeave()
    }
    
    func actionFailed(msg: String) {
        viewController?.actionFailed(message: msg)
    }
}
