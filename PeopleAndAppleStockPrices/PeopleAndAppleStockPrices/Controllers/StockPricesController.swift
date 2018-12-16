//
//  StockPricesController.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockPricesController: UIViewController {
  @IBOutlet weak var stockTableView: UITableView!
  private var stocks: [Stock] = []
  private var data: [String: [Stock]] = [:]
  private var keys: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stockTableView.delegate = self
        setupData()
      }
        // Do any additional setup after loading the view.
  
  private func setupData() {
    stocks = StockPriceAPI.fetchStocks()
    data = formatData(stocks: stocks)
    keys = data.keys.sorted {(first, second) in
    let firstDate = first.components(separatedBy:" ")
    let secondDate = second.components(separatedBy: " ")
    return (firstDate[0],firstDate[1]) <  (secondDate[0], secondDate[1])
    }
  }


  private func formatData(stocks:[Stock]) -> [String:[Stock]]{
    return Dictionary(grouping: stocks) {(element:Stock) in
      return "\(element.year) \(element.month)"
    }
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

extension StockPricesController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let keyForRowAt = keys[indexPath.section]
    guard let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockCell,
      let stocks = data[keyForRowAt] else { return UITableViewCell() }
    let stock = stocks[indexPath.row]
    cell.dateLabel.text = stock.date
    cell.OpenPriceLabel.text = String(format: "%.2f", stock.close)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let stockDate = keys[section]
    guard let stocks = data[stockDate] else { return 0 }
    return stocks.count
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return keys.count
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let key = keys[section]
    guard let stocks = data[key],
      let date = stocks.first?.formattedDate else { return ""}
    let allPrices = stocks.map {$0.close}
    let avg = allPrices.reduce(0, +) / Double(allPrices.count)
    let avgString = String(format: " %.2f", avg)
    return "\(date) Average: \(avgString)"
  }
}

extension StockPricesController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let detailVC = storyboard.instantiateViewController(withIdentifier: "StockDetail") as?
      StockDetailController else { return }
    let stock = stocks[indexPath.row]
    detailVC.stockInfo = stock
    navigationController?.pushViewController(detailVC, animated: true)
  }
}
