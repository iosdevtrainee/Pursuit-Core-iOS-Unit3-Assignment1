//
//  Stock_Prices.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Stock: Codable {
  public let date: String
  public let high: Double
  public let low: Double
  public let close: Double
  public let volume: Int
  public let label: String
  public let open: Double
  public var year: String {
    return date.components(separatedBy: "-")[0]
  }
  public var month: String {
    return date.components(separatedBy: "-")[1]
  }
  public var formattedDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    guard let thisDate = dateFormatter.date(from: self.date) else { return ""}
    dateFormatter.dateFormat = "MMM - YYYY"
    return dateFormatter.string(from: thisDate)
  }
}
