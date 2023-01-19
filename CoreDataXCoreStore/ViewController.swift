//
//  ViewController.swift
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 16/01/23.
//

import UIKit
import CoreStore

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func doMigration(_ sender: Any) {
        _ = CoreDataManager.instance
    }
    
    @IBAction func addRelationshipDataFromJson(_ sender: Any) {
        
        let jsonData: [String: Any] = [
            "invoiceId": "\(Int.random(in: 1000..<2000))",
            "bookingAmount": Int.random(in: 100000..<200000),
            "rescheduleId": "\(Int.random(in: 1000..<2000))",
            "bookingStatus": "\(["failed", "success", "pending"].randomElement()!)",
            "flightBookingDetail": [
                "multipleAirlines": Date(),
                "originDate": Date(),
                "twoWay": Bool.random()
            ],
            "insuranceDetail": [
                "insuranceStatus": "\(["active", "not active", "pending"].randomElement()!)",
                "providerId": "\(Int.random(in: 1000..<2000))",
                "productType": "\(["Regular", "VIP", "VVIP"].randomElement()!)",
                "insurancedPerson": [
                    [
                        "emailAddress": "\(["x@gmail", "x@tvlk", "x@facebook"].randomElement()!)",
                        "nationality": "\(["ID", "TH", "MY"].randomElement()!)",
                        "firstName": "\(["John", "Doe", "John Doe"].randomElement()!)",
                        "lastName": "\(["John", "Doe", "John Doe"].randomElement()!)",
                        "documentType": "\(["none", "docs", "prescription"].randomElement()!)"
                    ]
                ]
            ]
        ]
        
        CoreDataManager.instance.perform { transaction in
            try transaction.importUniqueObject(Into<FlightBookingInfo>(), source: jsonData)
        } success: { flightBookingInfo in
            let alert = UIAlertController(
                title: "Add Data",
                message: "Add object with invoice id \(flightBookingInfo?.invoiceId ?? "") succesfully",
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true, completion: nil)
            print(flightBookingInfo?.invoiceId ?? "")
        } failure: { error in
            print(error.localizedDescription)
        }
        
        
    }
    
    @IBAction func fetchDataWithCondition(_ sender: Any) {
        CoreDataManager.instance.safeDataStack { dataStack in
            do {
                // Swift ManagedObject
                let flightBookingInfo = try dataStack.fetchAll(
                    From<FlightBookingInfo>()
                        .where(\.bookingStatus == "success")
                        .orderBy(.ascending(\.invoiceId))
                )

                // Objective C ManagedObject
                let insuranceDetail = try dataStack.fetchAll(
                    From<InsuranceDetail>()
                        .where(\.insuranceStatus == "not active")
                        .orderBy(.descending(\.providerId))
                )

                let alert = UIAlertController(
                    title: "Fetch Data With where Condition",
                    message: """
                        fetch data swift nsmanaged object successfully \(flightBookingInfo.count) data, example data: \(flightBookingInfo.first?.invoiceId ?? "")\n
                        fetch from objc managed object success \(insuranceDetail.count) data, example data: \(insuranceDetail.last?.providerId ?? "") \(insuranceDetail.last?.insuranceStatus ?? "")
                    """,
                    preferredStyle: UIAlertController.Style.alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true, completion: nil)
            } catch {
                print("Failed to fetch data \(error)")
            }
        }
    }
    
    
    @IBAction func deleteObject(_ sender: Any) {
        CoreDataManager.instance.safeDataStack { dataStack in
            do {
                let flightBookingInfo = try dataStack.fetchOne(From<FlightBookingInfo>())
                let invoiceId: String = flightBookingInfo?.invoiceId ?? ""
                
                CoreDataManager.instance.perform { transaction in
                    transaction.delete(flightBookingInfo)
                } success: { object in
                    let alert = UIAlertController(
                        title: "Delete data",
                        message: "Delete object with id \(invoiceId) succesfully",
                        preferredStyle: UIAlertController.Style.alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true, completion: nil)
                } failure: { error in
                    print("Failed to delete data \(error)")
                }

            } catch {
                print("Failed to delete object \(error)")
            }
        }
    }
}

