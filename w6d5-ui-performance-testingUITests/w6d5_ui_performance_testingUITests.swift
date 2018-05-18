//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Mike Stoltman on 2018-05-18.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddMeal() {
        addNewMeal(mealName: "burger", numberOfCalories: 300)
//        deleteMeal(mealName: "burger", numberOfCalories: 300)
    }
    
    func testShowDetail() {
        showDetail(mealName: "burger", numberOfCalories: 300)
    }
    
    func showDetail(mealName: String, numberOfCalories: Int) {
        let tablesQuery = app.tables
        let staticText = tablesQuery.staticTexts["\(mealName.lowercased()) - \(numberOfCalories)"]
        if staticText.exists {
            staticText.tap()
            XCTAssert(app.staticTexts["detailViewControllerLabel"].exists)
            app.navigationBars["Detail"].buttons["Master"].tap()
        }
    }
    
    func deleteMeal(mealName: String, numberOfCalories: Int) {
        let tablesQuery = app.tables
        let staticText = tablesQuery.staticTexts["\(mealName.lowercased()) - \(numberOfCalories)"]
        if staticText.exists {
            staticText.swipeLeft()
            tablesQuery.buttons["Delete"].tap()
            
        }
    }
    
    func addNewMeal(mealName: String, numberOfCalories: Int) {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let addAMealAlert = app.alerts["Add a Meal"]
        
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.tap()
        
        for character in mealName.lowercased() {
            let key = app.keys["\(character)"]
            key.tap()
        }

        collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.tap()
        
        app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, letters\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let calories = String(numberOfCalories)
        
        for character in calories {
            let key = app.keys["\(character)"]
            key.tap()
        }

        addAMealAlert.buttons["Ok"].tap()
    }
}
