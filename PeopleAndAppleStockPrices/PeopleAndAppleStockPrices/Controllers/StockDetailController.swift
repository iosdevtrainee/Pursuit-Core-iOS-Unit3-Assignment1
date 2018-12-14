//
//  StockDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailController: UIViewController {
  public var stockInfo: Stock!
  @IBOutlet weak var stockImageView: UIImageView!
  @IBOutlet weak var stockOpenLabel: UILabel!
  @IBOutlet weak var stockCloseLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      if stockInfo.close > stockInfo.open {
        view.backgroundColor = .green
        stockImageView.image = UIImage(named: "thumbsUp")
      } else {
        view.backgroundColor = .red
        stockImageView.image = UIImage(named: "thumbsDown")
      }
      stockOpenLabel.text = "\(stockInfo.open)"
      stockCloseLabel.text = "\(stockInfo.close)"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
