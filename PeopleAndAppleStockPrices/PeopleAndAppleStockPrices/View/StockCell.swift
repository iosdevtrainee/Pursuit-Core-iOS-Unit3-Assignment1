//
//  StockCell.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var OpenPriceLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
