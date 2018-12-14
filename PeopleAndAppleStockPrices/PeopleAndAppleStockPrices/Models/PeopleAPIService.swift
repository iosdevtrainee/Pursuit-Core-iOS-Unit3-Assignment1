//
//  PeopleAPIService.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct PersonAPI {
  static func getPeople(completion:@escaping ([User]?,APIError?) -> Void){
    guard let path = Bundle.main.path(
      forResource: "userinfo", ofType: "json") else {
        completion(nil, .urlException("Incorrect Filename"))
        return
    }
    let url = URL(fileURLWithPath: path)
    do {
      let data = try Data.init(contentsOf: url)
      let searchData = try JSONDecoder().decode(User.OuterLayer.self, from: data)
      
      completion(searchData.results, nil)
    } catch {
      completion(nil, .decodingException(error))
    }
  }
}
