//
//  UserObject.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 12/03/2024.
//

import Foundation

struct UserObject: Identifiable, Codable {
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

extension UserObject {
    static var mockUser = UserObject(id: NSUUID().uuidString, fullname: "Hello World", email: "Hello@World.com")
}
