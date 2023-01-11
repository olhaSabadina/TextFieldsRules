//
//  PasswordValidationService.swift
//  TextFields
//
//  Created by Olya Sabadina on 2023-01-11.
//

import Foundation


struct ValidatePasswordMeneger {
    
    public func minimumCharacters(text: String) -> Bool {
        let regularExpression = ".{8,}"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: text)
    }
    public func oneCapitalLetter(text: String) -> Bool {
        let regularExpression = ".*[A-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: text)
    }
    public func oneLowerCaseLetter(text: String) -> Bool {
        let regularExpression = ".*[a-z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: text)
    }
    public func oneDigit(text: String) -> Bool {
        let regularExpression = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: text)
    }
    public func oneSpecialSymbol(text: String) -> Bool {
        let regularExpression = ".*[ @,<>=+*:;#~|/^!$%&?._-]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: text)
    }
}

