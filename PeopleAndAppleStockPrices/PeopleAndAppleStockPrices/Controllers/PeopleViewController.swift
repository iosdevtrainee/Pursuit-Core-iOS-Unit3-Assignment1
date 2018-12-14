//
//  PeopleViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
  private var people: [User] = [] {
    didSet {
      self.people = self.people.sorted { ($0.name.first,$0.name.last) < ($1.name.first,$1.name.last) }
      self.peopleTableView.reloadData()
    }
  }
  
  @IBOutlet weak var peopleTableView: UITableView!
  @IBOutlet weak var peopleSearchBar: UISearchBar!
  override func viewDidLoad() {
    super.viewDidLoad()
    peopleTableView.delegate = self
    peopleTableView.dataSource = self
    peopleSearchBar.delegate = self
    self.people = fetchPeople(nil)
    // Do any additional setup after loading the view.
  }
  
  private func fetchPeople(_ keyword:String?) -> [User] {
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



extension PeopleViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let detailVC = storyboard.instantiateViewController(withIdentifier: "PeopleDetail") as?
      PeopleDetailController else { return }
    let person = people[indexPath.row]
    detailVC.person = person
    navigationController?.pushViewController(detailVC, animated: true)
  }
}

extension PeopleViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
    let person = people[indexPath.row]
    cell.textLabel?.text = "\(person.name.first) \(person.name.last)"
    cell.detailTextLabel?.text = person.location.city
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
}

extension PeopleViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard let text = searchBar.text else { return }
    people = fetchPeople(text)
  }
  
}
