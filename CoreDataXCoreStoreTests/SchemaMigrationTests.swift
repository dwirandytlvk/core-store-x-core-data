//
//  CoreDataXCoreStoreTests.swift
//  CoreDataXCoreStoreTests
//
//  Created by Dwi Randy Herdinanto on 19/01/23.
//

import XCTest
@testable import CoreDataXCoreStore

final class SchemaMigrationTests: XCTestCase {
    
    func testSchemaMigration() throws {
        let sqliteUrl: [URL] = findSQLiteFile()
        
        for url in sqliteUrl {
            print("Migrate from \(url.lastPathComponent) to latest version")
            copySQLiteFileToAppDirectory(sqliteUrl: url)
            
            let exp = expectation(description: "Waiting until migration complete")
            
            CoreDataManager().safeDataStack { dataStack in
                exp.fulfill()
            }
            
            waitForExpectations(timeout: 3)
        }
    }
    
    private func findSQLiteFile() -> [URL] {
        let testBundle: Bundle = Bundle(for: type(of: self))
        let urls: [URL] = testBundle.urls(forResourcesWithExtension: "sqlite", subdirectory: nil) ?? []
        
        if urls.count == 0 {
            assertionFailure("Could not find sqlite file in test bundle")
        }
        
        return urls
    }
    
    private func copySQLiteFileToAppDirectory(sqliteUrl: URL) {
        let applicationSupportDirectory: URL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        
        let bundleIDDirectory: URL = applicationSupportDirectory.appendingPathComponent("com.dwirandyh.CoreDataXCoreStore")
        
        let sqliteFileName = sanitizeSQLFileName(sqlFileName: sqliteUrl.lastPathComponent)
        let sqliteDirectory: URL = bundleIDDirectory.appendingPathComponent(sqliteFileName)
        
        // Delete previous SQLite file
        do {
            try FileManager.default.removeItem(at: sqliteDirectory)
            print("Delete old SQLite file")
        } catch {
            print(error.localizedDescription)
        }
        
        do
        {
            try FileManager.default.createDirectory(at: bundleIDDirectory, withIntermediateDirectories: true, attributes: nil)
            
            try FileManager.default.copyItem(at: sqliteUrl, to: sqliteDirectory)
        }
        catch let error as NSError
        {
            print("Unable to create directory \(error.debugDescription)")
        }
    }
    
    private func sanitizeSQLFileName(sqlFileName: String) -> String {
        if let startRange = sqlFileName.range(of: "-"),
            let endRange = sqlFileName.range(of: ".sqlite") {
            let newString = sqlFileName.replacingCharacters(in: startRange.upperBound..<endRange.lowerBound, with: "")
            return newString.replacingCharacters(in: startRange, with: "")
        } else {
            return sqlFileName
        }
    }
    
}
