//
//  EntryVC.swift
//  Journal+Firebase
//
//  Created by Ivan Ramirez on 2/16/22.
//

import UIKit

class EntryVC: UIViewController {

    @IBOutlet weak var saveButton: IRButton!
    @IBOutlet weak var updateButton: IRButton!
    @IBOutlet weak var fetchAllButton: IRButton!
    @IBOutlet weak var fetchOneButton: IRButton!
    
    private let saveOption = 1
    private let updateOption = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        view.verticalGradient()
    }

    //Mark: - Alert Controller
    //TODO: - we need to call save or update function
    func presentAlert(updateOrSave option: Int) {
        var nameTextField: UITextField?
        var statusTextField: UITextField?
        var objectKeyTextField: UITextField?
        
        // Call func in AlertController file
        let firebaseAlert = AlertController.presentAlertControllerWith(alertTitle: "Employee Details", alertMessage: "Enter in the description", dismissActionTitle: "Cancel")
        
        firebaseAlert.addTextField { itemName in
            itemName.placeholder = "Enter Name"
            nameTextField = itemName
        }
        
        firebaseAlert.addTextField { itemStatus in
            itemStatus.placeholder = "Enter Status"
            statusTextField = itemStatus
        }
        
        firebaseAlert.addTextField { objectKey in
            objectKey.placeholder = "Enter Key if applicable"
            objectKeyTextField = objectKey
        }
        
        // Action to perform part of the alert controller
        let modifyDatabase = UIAlertAction(title: "Perform", style: .default) { _ in
            // what action does
            guard let name = nameTextField?.text, !name.isEmpty,
                  let status = statusTextField?.text,
                    let key = objectKeyTextField?.text else { return }
            // SAVE
            if option == self.saveOption {
                EmployeeController.shared.save(name: name, status: status)
            }
            
            // UPDATE
            if option == self.updateOption {
                EmployeeController.shared.update(objectKey: key, newName: name, newStatus: status)
            }
        }
        firebaseAlert.addAction(modifyDatabase)
        self.present(firebaseAlert, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        saveButton.shake()
        presentAlert(updateOrSave: saveOption)
    }

    @IBAction func updateButtonTapped(_ sender: Any) {
        updateButton.shake()
        presentAlert(updateOrSave: updateOption)
    }

    @IBAction func fetchAllButtonTapped(_ sender: Any) {
        fetchAllButton.shake()
        EmployeeController.shared.readAll()
    }

    @IBAction func fetchOneButtonTapped(_ sender: Any) {
        fetchOneButton.shake()
        EmployeeController.shared.readOne()
    }
}


