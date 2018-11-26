//
//  LongTextCell.swift
//  Image Machine
//
//  Created by Juanita Vyatri on 24/11/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import UIKit
import Eureka

open class LongTextCell: Cell<String>, CellType {

    @IBOutlet weak var label: UILabel!
    var LongTextRow: LongTextRow_! {
        return row as? LongTextRow_
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func update() {
        super.update()
        label.text = LongTextRow.text!
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

open class LongTextRow_: Row<LongTextCell> {
    
    open var text: String? = "Unknown"
    
    required public init(tag: String?) {
        super.init(tag: tag)
        // We set the cellProvider to load the .xib corresponding to our cell
        cellProvider = CellProvider<LongTextCell>(nibName: "LongTextCell")
    }
}

public final class LongTextRow: LongTextRow_, RowType { }
