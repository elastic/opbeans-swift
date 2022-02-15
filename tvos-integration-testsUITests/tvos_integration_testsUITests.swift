// Copyright © 2021 Elasticsearch BV
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

import XCTest

class tvos_integration_testsUITests: XCTestCase {




    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchEnvironment = ProcessInfo.processInfo.environment
        app.launch()
    
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["/api/customers"]/*[[".cells[\"\/api\/customers\"].staticTexts[\"\/api\/customers\"]",".staticTexts[\"\/api\/customers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells["/api/products"].otherElements.containing(.staticText, identifier:"/api/products").element.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["/api/orders"]/*[[".cells[\"\/api\/orders\"].staticTexts[\"\/api\/orders\"]",".staticTexts[\"\/api\/orders\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells["/1.jpg"].otherElements.containing(.staticText, identifier:"/1.jpg").element.tap()
        app.buttons["Navigation"].tap()

        do {
            sleep(2) // wait for exporter to export
        }
//        wait(for: [XCTestExpectation(description: "not an error")], timeout: 10)
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }


}
