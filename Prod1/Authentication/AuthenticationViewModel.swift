//
//  AuthenticationViewModel.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 12/03/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        print("LOGGED IN")
    }
    
    func signUp(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = UserObject(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder.encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("FAILED TO CREATE USER... \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        print("SIGNED OUT")
    }
    
    func deleteAccount() {
        print("ACCOUNT DELETED")
    }
    
    func fetchUser() {
        print("USER FETCHED")
    }
}
