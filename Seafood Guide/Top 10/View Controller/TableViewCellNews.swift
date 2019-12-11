//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  TableViewCellNews.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import QuartzCore
import UIKit

@objcMembers
class TableViewCellNews: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var textNewsLabel: UILabel!
    @IBOutlet weak var textNewsLabelContainer: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var circle: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

// MARK: - Button Style

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
