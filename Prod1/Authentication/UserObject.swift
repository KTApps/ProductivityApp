//
//  UserObject.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 12/03/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var mockUser = User(id: NSUUID().uuidString, fullname: "Hello World", email: "Hello@World.com")
}
