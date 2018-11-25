//
//  MachineDetailViewController.swift
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
import Eureka

protocol MachineDetailDisplayLogic: class
{
    func displaySomething(machine: Machine)
}

class MachineDetailViewController: FormViewController, MachineDetailDisplayLogic
{
    
    var interactor: MachineDetailBusinessLogic?
    var router: (NSObjectProtocol & MachineDetailRoutingLogic & MachineDetailDataPassing)?
    var machineId: String!
    var displayMode: String?
    var machine: Machine!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = MachineDetailInteractor()
        let presenter = MachineDetailPresenter()
        let router = MachineDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        machineId = (router?.dataStore?.machineId)!
        displayMode = (router?.dataStore?.displayMode)!
        self.navigationItem.rightBarButtonItems = nil
        if ((displayMode != nil) && (displayMode! == "edit" ||  displayMode! == "add")) {
            self.navigationItem.rightBarButtonItem = saveButton
            if displayMode! == "add" {
                setupEurekaForm()
                return
            }
        } else {
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItems = [trashButton, rightNavButton]
        }
        
        interactor?.doSomething(machineId: machineId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var rightNavButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    func setupEurekaForm()
    {
        let request = MachineDetail.Something.Request()
        interactor?.doSomething(machineId: machineId)
        
        form +++ Section("About Machine")
            <<< TextRow(){ row in
                row.title = "Id"
                row.placeholder = "Enter text here"
                if (displayMode! == "add") {
                    row.value = UUID().uuidString
                } else {
                    row.value = machine.machineId
                }
                row.disabled = true
                row.tag = "machineId"
            }
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter text here"
                if (displayMode! == "edit") {
                    row.value = machine.machineName
                }
                row.tag = "machineName"
            }
            <<< TextRow(){ row in
                row.title = "Type"
                row.placeholder = "Enter text here"
                if (displayMode! == "edit") {
                    row.value = machine.machineType
                }
                row.tag = "machineType"
            }
            <<< PhoneRow(){
                $0.title = "QRCode No."
                $0.placeholder = "And numbers here"
                if (displayMode! == "edit") {
                    $0.value = machine.QRCodeNumber
                }
                $0.tag = "QRCodeNumber"
            }
            <<< DateTimeRow() {
                $0.title = "Last Maintenance"
                if (displayMode! == "edit") {
                    $0.value = machine.lastMaintenanceDate
                } else {
                    $0.value = Date(timeIntervalSinceReferenceDate: 0)
                }
                $0.tag = "LastMaintenanceDate"
            }
            +++ Section("Images")
            <<< CarouselRow(){
                $0.addButtonTarget = self
                $0.addButtonAction = #selector(openImagePicker)
                $0.isEditingMode = true
                if (displayMode! == "edit") {
                    $0.Images = [] //machine.images
                } else {
                    $0.Images = []
                }
                $0.tag = "images"
            
        }
    }
    
    func setupEurekaDisplay()
    {
        form +++ Section("Machine Id")
            <<< LongTextRow() {
                $0.text = machine.machineId
            }
            +++ Section("Machine Name")
            <<< LongTextRow() {
                $0.text = machine.machineName
            }
            +++ Section("Machine Type")
            <<< LongTextRow() {
                $0.text = machine.machineType
            }
            +++ Section("QRCode Number")
            <<< LongTextRow() {
                $0.text = machine.QRCodeNumber
            }
            +++ Section("Last Maintenance")
            <<< LongTextRow() {
                $0.text = DateFormatter.localizedString(from: machine.lastMaintenanceDate, dateStyle: .short, timeStyle: .short)
            }
            +++ Section("Images")
            <<< CarouselRow(){
                $0.isEditingMode = false
                $0.Images = [] //machine.images
        }
    }
    
    @objc func openImagePicker() {
        
    }

    @IBAction func rightNavButtonTapped(_ sender: UIBarButtonItem) {
        
        if sender == saveButton {
            if displayMode == "add" {
                self.addMachine()
            } else {
                self.editMachine()
            }
        } else {
            router?.routeToEdit(machineId: machineId)
        }
    }
    
    func addMachine() {
        let values = form.values()
        let newMachine = Machine(machineId: values["machineId"] as! String, machineName: values["machineName"] as! String, machineType: values["machineType"] as! String, QRCodeNumber: values["QRCodeNumber"] as! String, lastMaintenanceDate: values["LastMaintenanceDate"] as! Date, images: [])
        var machines = [Machine]()
        if let data = UserDefaults.standard.data(forKey: "machines") {
            machines = try! PropertyListDecoder().decode([Machine].self, from: data)
        }
        machines.append(newMachine)
        
        do {
            try UserDefaults.standard.set(PropertyListEncoder().encode(machines), forKey: "machines")
            self.navigationController?.popViewController(animated: true)
        } catch {
            
        }
    }
    
    func editMachine() {
        let values = form.values()
        var machines = [Machine]()
        if let data = UserDefaults.standard.data(forKey: "machines") {
            machines = try! PropertyListDecoder().decode([Machine].self, from: data)
            var i = 0
            machines.forEach { (_oldMachine) in
                if _oldMachine.machineId == values["machineId"] as! String {
                    let newMachine = Machine(machineId: values["machineId"] as! String, machineName: values["machineName"] as! String, machineType: values["machineType"] as! String, QRCodeNumber: values["QRCodeNumber"] as! String, lastMaintenanceDate: values["LastMaintenanceDate"] as! Date, images: [])
                    machines.remove(at: i)
                    machines.append(newMachine)
                }
                i += 1
            }
        }
        
        do {
            try UserDefaults.standard.set(PropertyListEncoder().encode(machines), forKey: "machines")
            self.navigationController?.popViewController(animated: true)
        } catch {
            
        }
    }
    
    func displaySomething(machine: Machine)
    {
        self.machine = machine
        if ((displayMode != nil) && (displayMode! == "edit")) {
            self.setupEurekaForm()
        } else {
            self.setupEurekaDisplay()
        }
    }
}
