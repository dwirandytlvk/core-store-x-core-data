//
//  MappingModelV4To5.swift
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 19/01/23.
//

import Foundation

class InsurancedPersonV5MigrationPolicy: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        try super.createDestinationInstances(forSource: sInstance, in: mapping, manager: manager)
        
        for destinationInstance in manager.destinationInstances(forEntityMappingName: mapping.name, sourceInstances: [sInstance]) {
            let firstName: String = sInstance.primitiveValue(forKey: "firstName") as? String ?? ""
            let lastName: String = sInstance.primitiveValue(forKey: "lastName") as? String ?? ""
            let fullName: String = "\(firstName) \(lastName)"
            destinationInstance.setValue(fullName, forKey: #keyPath(InsurancedPerson.fullName))
        }
    }
}
