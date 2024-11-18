//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Prince  on 18/11/24.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    
    var Registration: [Registration] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Registration.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        let registration = Registration[indexPath.row]
        
        
        var content = cell.defaultContentConfiguration()
        content.text = registration.firstName + " " + registration.lastName; content.secondaryText = (registration.checkInDate..<registration.checkOutDate).formatted(date:.numeric, time: .omitted) + ": " + registration.roomType.name
        cell.contentConfiguration = content

        

        return cell
    }
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        
        guard let addRegistration_TableViewController = unwindSegue.source as? AddRegistration_TableViewController,
              
              let registration = addRegistration_TableViewController.registration else {
            return
        }
        Registration.append(registration)
        tableView.reloadData()
        
        
        
    }
    
  


}
