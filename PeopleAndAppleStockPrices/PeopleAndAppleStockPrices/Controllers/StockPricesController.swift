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
        stocks = fetchStocks()
        data = formatData(stocks: stocks)
        keys = data.keys.sorted {sortStringDates($0, $1) }
//        keys = keys.sorted() {sortStringDates($0, $1) }
      print(keys)
        // Do any additional setup after loading the view.
      
    }
  private func sortStringDates(_ firstDateString:String,
                               _ secondDateString:String) -> Bool {
    let firstDateComponenets = firstDateString.components(separatedBy: " - ")
    let secondDateComponenets = secondDateString.components(separatedBy: " - ")
    let firstDateMonth = firstDateComponenets[0]
    let secondDateMonth = secondDateComponenets[0]
    let firstDateYear = firstDateComponenets[1]
    let secondDateYear = secondDateComponenets[1]
      return (firstDateYear,firstDateMonth) < (secondDateYear, secondDateMonth)
    }

  private func formatData(stocks:[Stock]) -> [String:[Stock]]{
    return Dictionary(grouping: stocks) {(element:Stock) in
      let dateElements = element.date.components(separatedBy: "-")
      return "\(dateElements[1]) - \(dateElements[0])"
    }
  }
  
//  private func monthStringToMonth(_ monthStr:String) -> String{
//    switch monthStr {
//    case "01":
//      return "January"
//    case "02":
//      return "February"
//    case "03":
//      return "March"
//    case "04":
//      return "April"
//    case "05":
//      return "May"
//    case "06":
//      return "June"
//    case "07":
//      return "July"
//    case "08":
//      return "August"
//    case "09":
//      return "September"
//    case "10":
//      return "October"
//    case "11":
//      return "November"
//    case "12":
//      return "December"
//    default:
//      return ""
//    }
//  }
  
  private func fetchStocks() -> [Stock] {
    var stocks = [Stock]()
    StockPriceAPI.getPrices{ (data, error) in
      if let error = error {
        print(error)
      }
      if let data = data {
        stocks = data
      }
    }
    return stocks
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
    cell.OpenPriceLabel.text = String.init(format: "\(stock.close)", "%.2f")
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (data[keys[section]]?.count)!
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return keys.count
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    var date = keys[section].components(separatedBy: " - ")
//    date[0] = monthStringToMonth(date[0])
    guard let totalStockArray = data[keys[section]] else { return ""}
    let allPrices = totalStockArray.map {$0.close}
    let avg = allPrices.reduce(0, +) / Double(allPrices.count)
    return date.joined(separator: " - ") + " Average: \(avg)"
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
