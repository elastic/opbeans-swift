// Copyright © 2022 Elasticsearch BV
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

class opbeans_swift_loadgenerator: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPurchase() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        // select product from list
        let tableCell = app.tables.cells["Brazil Verde, Italian Roast, Dark Roast Coffee"]
        _ = tableCell.waitForExistence(timeout: 3)
        tableCell.tap()
        
        //add item to cart
        let addToCart = app.navigationBars.children(matching: .other)
        _ = addToCart.element.waitForExistence(timeout: 3)
        addToCart.element.tap()
        
        // return to product list
        app.navigationBars.buttons["Opbeans Coffee"].tap()
        
        // go to the cart
        let viewCart = app.navigationBars["Opbeans Coffee"].children(matching: .other).element(boundBy: 1)
        _ = viewCart.waitForExistence(timeout: 3)
        viewCart.tap()
        
        let checkout = app.navigationBars["Cart"].buttons["Checkout"]
        _ = checkout.waitForExistence(timeout: 3)
        checkout.tap()
        
        _ = app.wait(for: .runningBackground, timeout: 5)
    }
}
