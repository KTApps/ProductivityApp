//
//  UserObject.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 12/03/2024.
//

import Foundation

struct userObject: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter() // calls built in formatter
        if let components = formatter.personNameComponents(from: fullname) { // formatter splits users fullname into seperate Strings
            formatter.style = .abbreviated // formatter takes initials from the Strings
            return formatter.string(from: components) // formatter combines initials into 1 string
        }
        return ""
    }
}
