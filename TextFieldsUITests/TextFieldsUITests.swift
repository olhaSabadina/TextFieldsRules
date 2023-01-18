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
    let app = XCUIApplication()
    
    func testNoDigitsTFUserBehavior() {
        app.launch()
        app.textFields["noDigitsTF"].tap()
        app.textFields["noDigitsTF"].typeText("String with 235 digits")
        app.keyboards.buttons["Return"].tap()
        XCTAssertEqual(app.textFields["noDigitsTF"].value as! String, "String with  digits")
    }
    
    func testIndicationLimitedTFUserBehavior() {
        app.launch()
        app.textFields["indicationLimitedTextTF"].tap()
        app.textFields["indicationLimitedTextTF"].typeText("indicationLimitedTextField")
        app.keyboards.buttons["Return"].tap()
        XCTAssertEqual(app.textFields["indicationLimitedTextTF"].value as! String, "indicationLimitedTextField")
    }
    
    func testMaskTFUserBehavior() {
        app.launch()
        app.textFields["maskTF"].tap()
        app.textFields["maskTF"].typeText("abcdeddd12345567")
        app.keyboards.buttons["Return"].tap()
        XCTAssertEqual(app.textFields["maskTF"].value as? String, "abcde-12345")
    }
    
    func testLinkTFUserBehavior() {
        app.launch()
        app.textFields["linkTF"].tap()
        app.textFields["linkTF"].typeText("www.google.com")
        _ = app.wait(for: XCUIApplication.State.notRunning, timeout:10)
        XCTAssertTrue(app.webViews.images["Google"].exists)
    }
    
    func testPasswordTFUserBehavior() {
        app.launch()
        app.secureTextFields["passwordTF"].tap()
        app.secureTextFields["passwordTF"].typeText("1Aa/rrrr")
        app.keyboards.buttons["Return"].tap()
        XCTAssertEqual(app.secureTextFields["passwordTF"].value as? String, "••••••••")
    }
    
    func testClikToTabBarUserBehavior() {
        app.launch()
        XCTAssertTrue(app.buttons.element.exists)
        app.buttons["switchToTabBarBT"].tap()
        
    }
    
    func testTabBarNoDigitsUserBehavior() {
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["NO digits"].tap()
        app.textFields["enter any characters"].tap()
        app.textFields["enter any characters"].typeText("String with 235 digits")
        app.keyboards.buttons["Return"].tap()
        XCTAssertEqual(app.textFields["enter any characters"].value as? String, "String with  digits")
        app.buttons["Back to Home"].tap()
    }
    
    func testTabBarIndicationLimitedUserBehavior() {
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Input character"].tap()
        app.textFields["limit = 10 charecters"].tap()
        app.textFields["limit = 10 charecters"].typeText("indicationLimitedTextField")
        app.keyboards.buttons["Return"].tap()
        XCTAssertEqual(app.textFields["limit = 10 charecters"].value as? String, "indicationLimitedTextField")
        app.buttons["Back to Home"].tap()
    }
    
    func testTabBarMaskUserBehavior() {
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Mask w-d"].tap()
        app.textFields["wwwww-ddddd"].tap()
        app.textFields["wwwww-ddddd"].typeText("abcdeddd12345567")
        app.keyboards.buttons["Return"].tap()
        XCTAssertEqual(app.textFields["wwwww-ddddd"].value as? String, "abcde-12345")
        app.buttons["Back to Home"].tap()
    }
    
    func testTabBarLinkUserBehavior() {
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Link"].tap()
        app.buttons["Back to Home"].tap()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Link"].tap()
        app.textFields["www.example.com"].tap()
        app.textFields["www.example.com"].typeText("www.google.com")
        _ = app.wait(for: XCUIApplication.State.notRunning, timeout:10)
        XCTAssertTrue(app.webViews.images["Google"].exists)
    }
    
    func testTabBarPasswordUserBehavior() {
        app.launch()
        app.buttons["switchToTabBarBT"].tap()
        app.tabBars["Tab Bar"].buttons["Password"].tap()
        app.secureTextFields["input password"].tap()
        app.secureTextFields["input password"].typeText("1Aa/rrrr")
        app.keyboards.buttons["Return"].tap()
        XCTAssertEqual(app.secureTextFields["input password"].value as? String, "••••••••")
        app.buttons["Back to Home"].tap()
    }
    
}


