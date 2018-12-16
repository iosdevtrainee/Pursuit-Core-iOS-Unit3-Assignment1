//
//  PeopleAPIService.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct PersonAPI {
  public static func getPeople(completion:@escaping ([User]?,APIError?) -> Void){
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
  public static func fetchPeople(_ keyword:String?) -> [User] {
    var people = [User]()
    if keyword == "" || keyword == nil {
      PersonAPI.getPeople{ (data, error) in
        if let error = error {
          print(error)
        }
        if let data = data {
          people = data
        }
      }
      
    } else {
      
      PersonAPI.getPeople{ (data, error) in
        if let error = error {
          print(error)
        }
        if let data = data {
          people = data.filter{$0.name.first.lowercased().contains(keyword!.lowercased())}
        }
      }
      
    }
    
    return people
  }
  
}
