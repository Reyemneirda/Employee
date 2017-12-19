//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Adrien Meyer on 19/12/2017.
//  Copyright © 2017 ronny abraham. All rights reserved.
//



import UIKit

protocol EmployeeTypeTableViewControllerDelegate {
    
    func didSelectEmployeeType(employeeType: EmployeeType)
}

class EmployeeTypeTableViewController: UITableViewController
{

    var delegate: EmployeeTypeTableViewControllerDelegate?
    var employeeType: EmployeeType?
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return EmployeeType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTypeCell", for: indexPath)
        let employeeTypes = EmployeeType.all[indexPath.row]
        
        cell.textLabel?.text = employeeTypes.description()
        
        if employeeTypes == employeeType {
            
            cell.accessoryType = .checkmark
        } else {
            
            cell.accessoryType = .none
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        employeeType = EmployeeType.all[indexPath.row]
        delegate?.didSelectEmployeeType(employeeType: employeeType!)
        tableView.reloadData()
    }
    

    
    


}
