//
//  FlightBookingDetail.swift
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 16/01/23.
//

import Foundation
import CoreData
import CoreStore

public class FlightBookingDetail: NSManagedObject, ImportableObject {
    
    public typealias ImportSource = [String: Any]
    
    @NSManaged
    public var multipleAirlines: Bool
    @NSManaged
    public var originDate: Date?
    @NSManaged
    public var twoWay: Bool
    
    // Relationship
    @NSManaged
    public var flightBookingInfo: FlightBookingInfo?
    
    public func didInsert(from source: [String : Any], in transaction: CoreStore.BaseDataTransaction) throws {
        multipleAirlines = source["multipleAirlines"] as? Bool ?? false
        originDate = source["originDate"] as? Date
        twoWay = source["twoWay"] as? Bool ?? false
    }
}
