//
//  EmployeeController.swift
//  Journal+Firebase
//
//  Created by Ivan Ramirez on 2/16/22.
//

import Foundation
import FirebaseDatabase

struct EmployeeController {

    static var shared = EmployeeController()
    let ref = Database.database().reference()
    
    //Mark: - Alert Controller
    
    
    //Mark: - Save
    func save(name: String, status: String) {
        // adding ID and value to database
        ref.childByAutoId().setValue(["name" : "\(name)", "status" : "\(status)"])
    }
    
    //Mark: - Read All / Fetch All
    func readAll() {
        ref.observeSingleEvent(of: .value) { snapshot in
            // make sure there's something in database and data is good
            guard let dictionary = snapshot.value as? [String: [String: Any]] else {
                print("Error with reading dictionary in \(#function)")
                return
            }
            
            // Loop through array and print the name and status
            Array(dictionary.values).forEach {
                // give string of the first item $0[] or empty string if there is nothing
                let name = $0["name"] as? String ?? ""
                let status = $0["status"] as? String ?? ""
                
                print(name, status)
            }
        }
    }
    
    //Mark: - Read One
    func readOne() {
        ref.child("employee").observeSingleEvent(of: .value) { snapshot in
            let employeeData = snapshot.value as? [String: Any]
            
            print(employeeData ?? "No Data Fetched")
        }
    }
    
    //Mark: - Update
    func update(objectKey: String, newName: String, newStatus: String) {
        // objectKey = "employee", name = "Carlotta"
        ref.child("\(objectKey)/name").setValue(newName)
        ref.child("\(objectKey)/status").setValue(newStatus)
    }
    
}
