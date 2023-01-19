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
    
    func testIsContainsDigitsReturnTrue() {
        let textWithDigits = "String with 235 digits"
        XCTAssertTrue(sut1.isContainsDigits(text: textWithDigits))
    }
    func testIsContainsDigitsReturnFalse() {
        let textWithoutDigits = "String with digits"
        XCTAssertFalse(sut1.isContainsDigits(text: textWithoutDigits))
    }
    
    func testLetterAndDigitsMaskWhenWeInputFiveLettersReturnTrue() {
        let inputFiveLetters = "fgHJk"
        XCTAssertTrue(sut1.letterAndDigitsMask(text: inputFiveLetters))
    }
    
    func testLetterAndDigitsMaskWhenWeInputMoreThanFiveLettersReturnFalse() {
        let inputMoreThenFiveLetters = "fgHJkLM"
        XCTAssertFalse(sut1.letterAndDigitsMask(text: inputMoreThenFiveLetters))
    }
    
    func testLetterAndDigitsMaskWhenWeInputMinusReturnTrue() {
        let inputMinus = "fgHJk-"
        XCTAssertTrue(sut1.letterAndDigitsMask(text: inputMinus))
    }
    
    func testLetterAndDigitsMaskWhenWeInputFiveLetterMinusSixDigitsReturnFalse() {
        let inputFiveletterMinusSixDigits = "fgHJk-123456"
        XCTAssertFalse(sut1.letterAndDigitsMask(text: inputFiveletterMinusSixDigits))
    }
    
    func testLetterAndDigitsMaskWhenWeInputFiveletterMinusFiveDigitsReturnTrue() {
        let inputFiveletterMinusFiveDigits = "fgHJk-12345"
        XCTAssertTrue(sut1.letterAndDigitsMask(text: inputFiveletterMinusFiveDigits))
    }
    
    func testIsValideLinkMaskWithPrefixWWWReturnTrue() {
        let inputLink = "www.google.com"
        XCTAssertTrue(sut1.isValideLinkMask(text: inputLink))
    }
    
    func testIsValideLinkMaskWithPrefixHTTPSReturnTrue() {
        let inputLink = "https://google.com"
        XCTAssertTrue(sut1.isValideLinkMask(text: inputLink))
    }
    
    func testIsValideLinkMaskIfLinkIsNotValideReturnFalse() {
        let inputLink = ".google.com"
        XCTAssertFalse(sut1.isValideLinkMask(text: inputLink))
    }
    
    func testOneCapitalLetterWeHaveInPasswordReturnTrue() {
        let inputTexts = "A"
        XCTAssertTrue(sut2.oneCapitalLetter(text: inputTexts))
    }
    
    func testOneCapitalLetterWeHaveInPasswordReturnFalse() {
        let inputTexts = "a"
        XCTAssertFalse(sut2.oneCapitalLetter(text: inputTexts))
    }
    
    func testOneLowerCaseLetterWeHaveInPasswordReturnTrue() {
        let inputTexts = "b"
        XCTAssertTrue(sut2.oneLowerCaseLetter(text: inputTexts))
    }
    
    func testOneLowerCaseLetterWeHaveInPasswordReturnFalse() {
        let inputTexts = "B"
        XCTAssertFalse(sut2.oneLowerCaseLetter(text: inputTexts))
    }
    
    func testOneDigitWeHaveInPasswordReturnTrue() {
        let inputTexts = "3"
        XCTAssertTrue(sut2.oneDigit(text: inputTexts))
    }
    func testOneDigitWeHaveInPasswordReturnFalse() {
        let inputTexts = "r"
        XCTAssertFalse(sut2.oneDigit(text: inputTexts))
    }
    
    func testMinimumCharactersIfWeHaveInPassword5CharactersReturnFalse() {
        let inputTextsContains5Characters = "asd/2"
        XCTAssertFalse(sut2.minimumCharacters(text: inputTextsContains5Characters))
    }
    
    func testMinimumCharactersIfWeHaveInPassword8OrMoreCharactersReturnTrue() {
        let inputTextsContains8OrMoreCharacters = "asd12//[fghgjgjhk"
        XCTAssertTrue(sut2.minimumCharacters(text: inputTextsContains8OrMoreCharacters))
    }
    
    func testMinimumCharactersIfWeHaveInPasswordOnly8CharactersReturnTrue() {
        let inputTexts8Characters = "asd12//["
        XCTAssertTrue(sut2.minimumCharacters(text: inputTexts8Characters))
    }
    
    func testOneSpecialSymbolWeHaveInPasswordReturnTrue() {
        let inputTextsContainsSpecialSymbol = "saa/555"
        XCTAssertTrue(sut2.oneSpecialSymbol(text: inputTextsContainsSpecialSymbol))
    }
    
    func testOneSpecialSymbolWeHaveOneOrMoreSpecialSymbolInPasswordReturnTrue() {
        let inputTextsContainsSpecialSymbols = "saa/[{555"
        XCTAssertTrue(sut2.oneSpecialSymbol(text: inputTextsContainsSpecialSymbols))
    }
    
    func testOneSpecialSymbolIfWeDosNotHaveSpecialSymbolInPasswordReturnFalse() {
        let inputTextsNotContainsSpecialSymbol = "saa555"
        XCTAssertFalse(sut2.oneSpecialSymbol(text: inputTextsNotContainsSpecialSymbol))
    }
}
