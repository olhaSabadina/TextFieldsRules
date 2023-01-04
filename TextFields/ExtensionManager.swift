//
//  Model.swift
//  TextFields
//
//  Created by Olya Sabadina on 2022-12-14.
//

//import Foundation
import UIKit
import Foundation

// regex https://emailregex.com/regular-expressions-cheat-sheet/

extension String {
    
    public func noDigits() -> Bool {
        let regularExpression = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: self)
    }
    
    public func letterAndDigitsMask() -> Bool {
        var regularExpression = ""
        if self.count <= 5 {
            regularExpression = "[a-zA-Zа-яА-Я]{0,5}"
        } else {
            regularExpression = "^[a-zA-Zа-яА-Я]{5} ?-? ?[0-9]{0,5}$"
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
    
    public func isValidelinkMask() -> Bool {
        var regularExpression = ""
        regularExpression = "^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
    
    public func minimumCharacters() -> Bool {
        let regularExpression = ".{8,}"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: self)
    }
    public func oneCapitalLetter() -> Bool {
        let regularExpression = ".*[A-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: self)
    }
    public func oneLowerCaseLetter() -> Bool {
        let regularExpression = ".*[a-z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: self)
    }
    public func oneDigit() -> Bool {
        let regularExpression = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: self)
    }
    public func oneSpecialSymbol() -> Bool {
        let regularExpression = ".*[ @,<>=+*:;#~|/^!$%&?._-]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: self)
    }
}





