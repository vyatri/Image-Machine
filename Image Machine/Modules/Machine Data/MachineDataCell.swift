//
//  MachineDataCell.swift
//  Image Machine
//
//  Created by Juanita Vyatri on 24/11/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import UIKit

class MachineDataCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(_ model: MachineData.Something.ViewModel) {
        nameLabel.text = model.machineName
        typeLabel.text = model.machineType
    }
}
