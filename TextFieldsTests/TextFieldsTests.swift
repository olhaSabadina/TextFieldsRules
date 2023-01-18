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
    
    //    MARK testManager Does string contains digits?
    
    func testWhenReceivedDigistReturnTrue() {
        let textWithDigits = "String with 235 digits"
        XCTAssertTrue(sut1.isContainsDigits(text: textWithDigits))
    }
    func testWhenReceivedDigistReturnFalse() {
        let textWithoutDigits = "String with digits"
        XCTAssertFalse(sut1.isContainsDigits(text: textWithoutDigits))
    }
    
    //    MARK testManager MaskIsFiveletterMinusFiveDigits like wwwww-ddddd
    
    func testInputMaskFiveletterMinusFiveDigitsWhenInputFiveLetters() {
        let inputFiveLetters = "fgHJk"
        XCTAssertTrue(sut1.letterAndDigitsMask(text: inputFiveLetters))
    }
    
    func testInputMaskFiveletterMinusFiveDigitsWhenInputMoreThenFiveLetters() {
        let inputMoreThenFiveLetters = "fgHJkLM"
        XCTAssertFalse(sut1.letterAndDigitsMask(text: inputMoreThenFiveLetters))
    }
    
    func testInputMaskFiveletterMinusFiveDigitsWhenInputMinus() {
        let inputMinus = "fgHJk-"
        XCTAssertTrue(sut1.letterAndDigitsMask(text: inputMinus))
    }
    
    func testInputMaskFiveletterMinusFiveDigitsWhenInputFiveletterMinusSixDigits() {
        let inputFiveletterMinusSixDigits = "fgHJk-123456"
        XCTAssertFalse(sut1.letterAndDigitsMask(text: inputFiveletterMinusSixDigits))
    }
    
    func testInputMaskFiveletterMinusFiveDigitsWhenUserDoesNotInputMinus() {
        let inputFiveletterFiveDigits = "fgHJk12345"
        XCTAssertTrue(sut1.letterAndDigitsMask(text: inputFiveletterFiveDigits))
    }        // minus will be inputeded automatically
    
    func testInputMaskFiveletterMinusFiveDigitsWhenInputFiveletterMinusFiveDigits() {
        let inputFiveletterMinusFiveDigits = "fgHJk-12345"
        XCTAssertTrue(sut1.letterAndDigitsMask(text: inputFiveletterMinusFiveDigits))
    }
    
    //    MARK testManager link Mask
    
    func testIsValideLinkMaskWithPrefixWWW() {
        let inputLink = "www.google.com"
        XCTAssertTrue(sut1.isValideLinkMask(text: inputLink))
    }
    
    func testIsValideLinkMaskWithPrefixHTTPS() {
        let inputLink = "https://google.com"
        XCTAssertTrue(sut1.isValideLinkMask(text: inputLink))
    }
    
    func testIsValideLinkMaskIfLinkIsNotValide() {
        let inputLink = ".google.com"
        XCTAssertFalse(sut1.isValideLinkMask(text: inputLink))
    }
    
    //    MARK test Validate Password Manager
    
    func testIsValideOneCapitalLetterReturnTrue() {
        let inputTexts = "A"
        XCTAssertTrue(sut2.oneCapitalLetter(text: inputTexts))
    }
    
    func testIsValideOneCapitalLetterReturnFalse() {
        let inputTexts = "a"
        XCTAssertFalse(sut2.oneCapitalLetter(text: inputTexts))
    }
    
    func testIsValideOneLowerCaseLetterReturnTrue() {
        let inputTexts = "b"
        XCTAssertTrue(sut2.oneLowerCaseLetter(text: inputTexts))
    }
    
    func testIsValideOneLowerCaseLetterReturnFalse() {
        let inputTexts = "B"
        XCTAssertFalse(sut2.oneLowerCaseLetter(text: inputTexts))
    }
    
    func testIsValideOneDigitReturnTrue() {
        let inputTexts = "3"
        XCTAssertTrue(sut2.oneDigit(text: inputTexts))
    }
    func testIsValideOneDigitReturnFalse() {
        let inputTexts = "r"
        XCTAssertFalse(sut2.oneDigit(text: inputTexts))
    }
    
    func testIsValideMinimumCharactersIfInput5Characters() {
        let inputTextsContains5Characters = "asd/2"
        XCTAssertFalse(sut2.minimumCharacters(text: inputTextsContains5Characters))
    }
    
    func testIsValideMinimumCharactersIfInput8OrMoreCharacters() {
        let inputTextsContains8OrMoreCharacters = "asd12//[fghgjgjhk"
        XCTAssertTrue(sut2.minimumCharacters(text: inputTextsContains8OrMoreCharacters))
    }
    
    func testIsValideMinimumCharactersIfInput8Characters() {
        let inputTexts8Characters = "asd12//["
        XCTAssertTrue(sut2.minimumCharacters(text: inputTexts8Characters))
    }
    
    func testIsValideOneSpecialSymbol() {
        let inputTextsContainsSpecialSymbol = "saa/555"
        XCTAssertTrue(sut2.oneSpecialSymbol(text: inputTextsContainsSpecialSymbol))
    }
    
    func testIsValideOneOrMoreSpecialSymbol() {
        let inputTextsContainsSpecialSymbol = "saa/[{555"
        XCTAssertTrue(sut2.oneSpecialSymbol(text: inputTextsContainsSpecialSymbol))
    }
    
    func testIsValideSpecialSymbolWhenTextDosNotHaveSpecialSymbol() {
        let inputTextsNotContainsSpecialSymbol = "saa555"
        XCTAssertFalse(sut2.oneSpecialSymbol(text: inputTextsNotContainsSpecialSymbol))
    }
    
}
