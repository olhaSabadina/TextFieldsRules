//
//  Model.swift
//  TextFields
//
//  Created by Olya Sabadina on 2022-12-14.
//

import Foundation

struct ValidateManager {
    
    public func isContainsDigits(text: String) -> Bool {
        let regularExpression = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: text)
    }
    
    public func letterAndDigitsMask(text: String) -> Bool {
        var regularExpression = ""
        if text.count <= 5 {
            regularExpression = "[a-zA-Zа-яА-Я]{0,5}"
        } else {
            regularExpression = "^[a-zA-Zа-яА-Я]{5} ?-? ?[0-9]{0,5}$"
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: text)
    }
    
    public func isValideLinkMask(text: String) -> Bool {
        var regularExpression = ""
        regularExpression = "^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: text)
    }
}

