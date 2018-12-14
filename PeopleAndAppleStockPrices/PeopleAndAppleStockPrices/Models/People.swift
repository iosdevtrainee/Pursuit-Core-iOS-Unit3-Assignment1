//
//  People.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct User: Codable {
  struct OuterLayer: Codable {
    public let results: [User]
  }
  struct NameWrapper: Codable {
    public let first: String
    public let last: String
    public let title: String?
  }
  public let name: NameWrapper
  public let gender: String
  public let email: String
  struct LoginData: Codable {
    public let username: String
    public let password: String
  }
  public let dob: String
  public let registered: String
  public let phone: String
  public let cell: String
  struct UserProfile: Codable {
    public let name: String
    public let value: String
  }
  public let id: UserProfile
  struct Picture: Codable {
    public let large: URL
    public let medium: URL
    public let thumbnail: URL
  }
  public let picture: Picture
  public let location: Location
  struct Location: Codable {
    public let city: String
  }
}
