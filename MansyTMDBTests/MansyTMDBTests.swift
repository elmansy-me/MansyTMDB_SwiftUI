//
//  MansyTMDBTests.swift
//  MansyTMDBTests
//
//  Created by Ahmed Elmansy on 02/08/2023.
//

import XCTest
import SwiftUI
import MansyTMDBCore
@testable import MansyTMDB

final class MansyTMDBAppTests: XCTestCase {

    func testMansyTMDBAppInitialization() {
        // When
        let _ = MansyTMDBApp()
        
        // Then
        XCTAssertTrue(MansyTMDBCore.isConfigured, "The MansyTMDBCore should be configured with the correct API key")
    }
    
}
