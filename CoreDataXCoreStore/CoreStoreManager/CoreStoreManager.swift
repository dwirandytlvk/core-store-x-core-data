//
//  CoreStoreManager.swift
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 16/01/23.
//

import Foundation
import CoreStore

class CoreDataManager {
    
    static let instance: CoreDataManager = CoreDataManager()
    
    private var dataStack: DataStack?
    
    let group = DispatchGroup()
    
    init() {
        createDataStack()
    }
    
    func safeDataStack(task: @escaping (_ dataStack: DataStack) -> Void) {
        group.notify(queue: DispatchQueue.main) {
            guard let initializedDataStack = self.dataStack else {
                assertionFailure("Data Stack is not initialized yet")
                return
            }
            
            task(initializedDataStack)
        }
    }
    
    func createDataStack() {
        group.enter()
        
        let currentStack: DataStack = DataStack(
            xcodeModelName: "MyBooking",
            bundle: Bundle.main,
            migrationChain: ["MyBooking", "MyBookingV2", "MyBookingV3", "MyBookingV4", "MyBookingV5"]
        )
        
        _ = currentStack.addStorage(
            SQLiteStore(
                fileName: "MyBooking.sqlite"
            ),
//            InMemoryStore(),
            completion: { (result) -> Void in
                switch result {
                case .success(let storage):
                    print("Successfully added sqlite store: \(storage)")
                case .failure(let error):
                    assertionFailure(error.localizedDescription)
                }
                
                self.group.leave()
            }
        )
        
        
        self.dataStack = currentStack
    }
    
    public func perform<T>(
        asynchronous task: @escaping (_ transaction: AsynchronousDataTransaction) throws -> T,
        sourceIdentifier: Any? = nil,
        success: @escaping (T) -> Void,
        failure: @escaping (CoreStoreError) -> Void
    ) {
        group.notify(queue: DispatchQueue.main) {
            self.dataStack?.perform(asynchronous: task, success: success, failure: failure)
        }
        
    }
    
}
