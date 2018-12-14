//
//  Lib.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation
enum APIError: Error {
  case urlException(String)
  case decodingException(Error)
//  case networkException(Error)
}

