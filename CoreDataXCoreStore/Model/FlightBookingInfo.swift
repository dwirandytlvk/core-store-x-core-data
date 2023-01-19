//
//  FlightBookingInfo.swift
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 16/01/23.
//

import Foundation
import CoreData
import CoreStore

class FlightBookingInfo: NSManagedObject, ImportableUniqueObject {
    
    typealias UniqueIDType = String
    
    static var uniqueIDKeyPath: String = String(keyPath: \FlightBookingInfo.invoiceId)
    
    typealias ImportSource = [String: Any]
    
    static func uniqueID(from source: [String : Any], in transaction: CoreStore.BaseDataTransaction) throws -> String? {
        return source["invoiceId"] as? String
    }
    
    @NSManaged
    var invoiceId: String
    @NSManaged
    var bookingStatus: String
    @NSManaged
    var rescheduleId: String
    @NSManaged
    var bookingAmount: Int32
    @NSManaged
    var rescheduleDetailDisplay: String
    
    // Relationship
    @NSManaged
    var flightBookingDetail: FlightBookingDetail?
    
    @NSManaged
    var insuranceDetail: InsuranceDetail?
    
    
    func update(from source: [String: Any], in transaction: CoreStore.BaseDataTransaction) throws {
        self.invoiceId = source["invoiceId"] as? String ?? ""
        self.bookingStatus = source["bookingStatus"] as? String ?? ""
        self.rescheduleId = source["rescheduleId"] as? String ?? ""
        self.bookingAmount = source["bookingAmount"] as? Int32 ?? 0
        self.rescheduleDetailDisplay = source["rescheduleDetailDisplay"] as? String ?? ""
        self.flightBookingDetail = try transaction.importObject(Into<FlightBookingDetail>(), source: source["flightBookingDetail"] as? [String: Any] ?? [:])
        
        self.insuranceDetail = InsuranceDetail(dictionary: source["insuranceDetail"] as? [String: Any] ?? [:], context: transaction.unsafeContext())
    }
    
    
}
