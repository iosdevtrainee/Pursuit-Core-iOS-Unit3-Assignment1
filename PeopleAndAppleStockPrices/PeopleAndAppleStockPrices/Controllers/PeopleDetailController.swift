//
//  PeopleDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by J on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailController: UIViewController {
  public var person: User!
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var personImageView: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      updateVC()
    }
  
  
  private func updateVC() {
    guard let person = person else { return }
    nameLabel.text = "\(person.name.first) \(person.name.last)"
    emailLabel.text = person.email
    cityLabel.text = person.location.city
    guard let imageData = getImage(imageURL: person.picture.large) else { return }
    personImageView.image = UIImage(data: imageData)
    
    
  }
  private func getImage(imageURL:URL) -> Data? {
    let data:Data?
    do {
      data = try Data(contentsOf: imageURL)
    } catch {
      print(error)
      return nil
    }
    return data
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


