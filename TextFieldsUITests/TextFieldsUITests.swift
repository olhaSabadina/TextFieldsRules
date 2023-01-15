//
//  TextFieldsUITests.swift
//  TextFieldsUITests
//
//  Created by Olya Sabadina on 2023-01-03.
//

import XCTest
import SafariServices

@testable import TextFields

final class TextFieldsUserBehaviorUITests: XCTestCase {
    
    func testNoDigitsTFUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["noDigitsTF"].tap()
        app.textFields["noDigitsTF"].typeText("String with 235 digits")
        app.keyboards.buttons["Return"].tap()
    }
    
    func testIndicationLimitedTFUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["indicationLimitedTextTF"].tap()
        app.textFields["indicationLimitedTextTF"].typeText("indicationLimitedTextField")
        app.keyboards.buttons["Return"].tap()
    }
    
    func testMaskTFUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["maskTF"].tap()
        app.textFields["maskTF"].typeText("abcde-12345")
        app.keyboards.buttons["Return"].tap()
    }
    
    func testLinkTFUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["linkTF"].tap()
        app.textFields["linkTF"].typeText("www.google.com")
        app.wait(for: XCUIApplication.State.notRunning, timeout: 4)
        app.otherElements["URL"].tap()
        XCTAssert(app.waitForExistence(timeout: 4))
    }
    
    func testPasswordTFUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.secureTextFields["passwordTF"].tap()
        app.secureTextFields["passwordTF"].typeText("1Aa/rrrr")
        app.keyboards.buttons["Return"].tap()
    }
    
    func testClikToTabBarUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
    }
    
    func testTabBarNoDigitsUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["NO digits"].tap()
        app.textFields["enter any characters"].tap()
        app.textFields["enter any characters"].typeText("String with 235 digits")
        app.keyboards.buttons["Return"].tap()
        app.buttons["Back to Home"].tap()
    }
    
    func testTabBarIndicationLimitedUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Input character"].tap()
        app.textFields["limit = 10 charecters"].tap()
        app.textFields["limit = 10 charecters"].typeText("indicationLimitedTextField")
        app.keyboards.buttons["Return"].tap()
        app.buttons["Back to Home"].tap()
    }
    
    func testTabBarMaskUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Mask w-d"].tap()
        app.textFields["wwwww - ddddd"].tap()
        app.textFields["wwwww - ddddd"].typeText("abcde-12345")
        app.keyboards.buttons["Return"].tap()
        app.buttons["Back to Home"].tap()
    }
    
    func testTabBarLinkUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Link"].tap()
        app.buttons["Back to Home"].tap()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Link"].tap()
        app.textFields["www.example.com"].tap()
        app.textFields["www.example.com"].typeText("www.google.com")
        app.wait(for: XCUIApplication.State.notRunning, timeout: 4)
        app.otherElements["URL"].tap()
        XCTAssert(app.waitForExistence(timeout: 4))
        
    }
    
    func testTabBarPasswordUserBehavior() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Password"].tap()
        app.secureTextFields["input password"].tap()
        app.secureTextFields["input password"].typeText("1Aa/rrrr")
        app.keyboards.buttons["Return"].tap()
        app.buttons["Back to Home"].tap()
    }
    
}
