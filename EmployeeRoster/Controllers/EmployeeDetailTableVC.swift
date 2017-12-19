//
//  EmployeeTableVC.swift
//  EmployeeRoster
//
//  Created by ronny abraham on 12/19/17.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import UIKit

class EmployeeDetailTableVC: UITableViewController, UITextFieldDelegate {

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    let dobRow = 1
    let dobPickerRow = 2
    let defaultRowHeight: CGFloat = 44
    
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var employeeTypeLabel: UILabel!
    @IBOutlet weak var datepickerCell: UITableViewCell!
    
    var employee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        
        dobLabel.text = formatDate(date: dobDatePicker.date)
    }
    
    
    
    var isEditingBirthday: Bool = false {
        didSet {
            dobDatePicker.isHidden = !isEditingBirthday
            tableView.beginUpdates()
            tableView.endUpdates()
        }
      
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row == dobRow else {return}
        isEditingBirthday = !isEditingBirthday
        dobLabel.textColor = .black
        dobLabel.text = formatDate(date: dobDatePicker.date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard indexPath.row == dobPickerRow else {return defaultRowHeight}
        if isEditingBirthday {
            return dobDatePicker.frame.height
        }
        return 0
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let name = nameTextField.text {
            employee = Employee(name: name, dateOfBirth: Date(), employeeType: .exempt)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
