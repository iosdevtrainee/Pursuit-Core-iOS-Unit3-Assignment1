//
//  StockAPIService.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct StockPriceAPI {
  static func getPrices(completion:@escaping ([Stock]?,APIError?) -> Void){
    guard let path = Bundle.main.path(
      forResource: "applstockinfo", ofType: "json") else {
        completion(nil, .urlException("Incorrect Filename"))
        return
    }
    let url = URL(fileURLWithPath: path)
    do {
      let data = try Data.init(contentsOf: url)
      let stock = try JSONDecoder().decode([Stock].self, from: data)
      completion(stock, nil)
    } catch {
      completion(nil, .decodingException(error))
    }
  }
}
