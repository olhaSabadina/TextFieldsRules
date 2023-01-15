//
//  TextFieldsTests.swift
//  TextFieldsTests
//
//  Created by Olya Sabadina on 2023-01-03.
//

import XCTest

@testable import TextFields

final class TextFieldsUnitTests: XCTestCase {
    
    var sut1 = ValidateManager()
    var sut2 = ValidatePasswordManager()
    
    func testTextFieldsWithNoDigitsBehaviour() {
        let inputTexts = "String with 235 digits"
        XCTAssertTrue(sut1.noDigits(text: inputTexts))
    }
    
    func testTextFieldsletterAndDigitsMaskBehaviour() {
        let inputTexts = "abcde-12345"
        XCTAssertTrue(sut1.letterAndDigitsMask(text: inputTexts))
    }
    
    func testTextFieldsisValidelinkMaskBehaviour() {
        let inputTexts = "www.google.com"
        XCTAssert(sut1.isValidelinkMask(text: inputTexts))
    }
    
    func testTextFieldsisValidelOneCapitalLetter() {
        let inputTexts = "A"
        XCTAssert(sut2.oneCapitalLetter(text: inputTexts))
    }
    
    func testTextFieldsisValidelOneLowerCaseLetter() {
        let inputTexts = "a"
        XCTAssert(sut2.oneLowerCaseLetter(text: inputTexts))
    }
    
    func testTextFieldsisValidelOneDigit() {
        let inputTexts = "3"
        XCTAssert(sut2.oneDigit(text: inputTexts))
    }
    
    func testTextFieldsisValideMinimumCharacters() {
        let inputTexts = "asd12//["
        XCTAssert(sut2.minimumCharacters(text: inputTexts))
    }
    
    func testTextFieldsisValideOneSpecialSymbol() {
        let inputTexts = "/"
        XCTAssert(sut2.oneSpecialSymbol(text: inputTexts))
    }
}
