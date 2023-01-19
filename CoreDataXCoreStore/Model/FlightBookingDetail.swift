//
//  FlightBookingDetail.swift
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 16/01/23.
//

import Foundation
import CoreData
import CoreStore

class FlightBookingDetail: NSManagedObject, ImportableObject {
    
    typealias ImportSource = [String: Any]
    
    @NSManaged
    var multipleAirlines: Bool
    @NSManaged
    var originDate: Date?
    @NSManaged
    var twoWay: Bool
    
    // Relationship
    @NSManaged
    var flightBookingInfo: FlightBookingInfo?
    
    func didInsert(from source: [String : Any], in transaction: CoreStore.BaseDataTransaction) throws {
        multipleAirlines = source["multipleAirlines"] as? Bool ?? false
        originDate = source["originDate"] as? Date
        twoWay = source["twoWay"] as? Bool ?? false
    }
}
