//
//  FlightBookingInfo.swift
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 16/01/23.
//

import Foundation
import CoreData
import CoreStore

@objc
public class FlightBookingInfo: NSManagedObject, ImportableUniqueObject {
    
    public typealias UniqueIDType = String
    
    public static var uniqueIDKeyPath: String = String(keyPath: \FlightBookingInfo.invoiceId)
    
    public typealias ImportSource = [String: Any]
    
    public static func uniqueID(from source: [String : Any], in transaction: CoreStore.BaseDataTransaction) throws -> String? {
        return source["invoiceId"] as? String
    }
    
    @NSManaged
    public var invoiceId: String
    @NSManaged
    public var bookingStatus: String
    @NSManaged
    public var rescheduleId: String
    @NSManaged
    public var bookingAmount: Int32
    @NSManaged
    public var rescheduleDetailDisplay: String
    
    // Relationship
    @NSManaged
    public var flightBookingDetail: FlightBookingDetail?
    
    @NSManaged
    var insuranceDetail: InsuranceDetail?
    
    
    public func update(from source: [String: Any], in transaction: CoreStore.BaseDataTransaction) throws {
        self.invoiceId = source["invoiceId"] as? String ?? ""
        self.bookingStatus = source["bookingStatus"] as? String ?? ""
        self.rescheduleId = source["rescheduleId"] as? String ?? ""
        self.bookingAmount = source["bookingAmount"] as? Int32 ?? 0
        self.rescheduleDetailDisplay = source["rescheduleDetailDisplay"] as? String ?? ""
        self.flightBookingDetail = try transaction.importObject(Into<FlightBookingDetail>(), source: source["flightBookingDetail"] as? [String: Any] ?? [:])
        
        self.insuranceDetail = InsuranceDetail(dictionary: source["insuranceDetail"] as? [String: Any] ?? [:], context: transaction.unsafeContext())
    }
    
    
}
