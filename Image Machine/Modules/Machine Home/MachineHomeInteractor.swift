//
//  MachineHomeInteractor.swift
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

protocol MachineHomeBusinessLogic
{
  func doSomething(request: MachineHome.Something.Request)
}

protocol MachineHomeDataStore
{
  //var name: String { get set }
}

class MachineHomeInteractor: MachineHomeBusinessLogic, MachineHomeDataStore
{
  var presenter: MachineHomePresentationLogic?
  var worker: MachineHomeWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: MachineHome.Something.Request)
  {
    worker = MachineHomeWorker()
    worker?.doSomeWork()
    
    let response = MachineHome.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
