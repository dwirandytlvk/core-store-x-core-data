//
//  MappingV4ToV5.swift
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 19/01/23.
//

import Foundation
import CoreStore

enum SchemaMappingV4ToV5 {
    static var mapping: CustomSchemaMappingProvider {
        return CustomSchemaMappingProvider(
            from: "MyBookingV4",
            to: "MyBookingV5",
            entityMappings: [
                InsurancedPerson.FromV4.transform
            ]
        )
    }
}

extension InsurancedPerson {
    enum FromV4 {
        static var transform: CustomSchemaMappingProvider.CustomMapping {
            return .transformEntity(sourceEntity: "InsurancedPerson", destinationEntity: "InsurancedPerson", transformer: { sourceObject, createDestinationObject in
                let destination = createDestinationObject()
                
                // copying all attribute from previous version
                destination.enumerateAttributes { (destinationAttribute, sourceAttribute) in
                    if let sourceAttribute = sourceAttribute {
                        destination[destinationAttribute] = sourceObject[sourceAttribute]
                    }
                }
                
                // merge firstName & lastName column
                let firstName: String = sourceObject["firstName"] as? String ?? ""
                let lastName: String = sourceObject["lastName"] as? String ?? ""
                destination["fullname"] = "\(firstName) \(lastName)"
            })
        }
    }
}
