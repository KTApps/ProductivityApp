//
//  AuthenticationViewModel.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 12/03/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthFormValidation {
    var isFormValid: Bool { get }
}

@MainActor
class AuthModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("LOG IN Failed... \(error.localizedDescription)")
        }
    }
    
    func signUp(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("SIGN UP Failed... \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // backend sign out
            self.userSession = nil // takes us back to login screen
            self.currentUser = nil // stops old data from appearing when logged into new user
        } catch {
            print("SIGNED OUT Failed... \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        print("ACCOUNT DELETED")
    }
    
    func fetchUser() async {
        guard let currentUserId = Auth.auth().currentUser?.uid
        else {
            return
        }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(currentUserId).getDocument()
        else {
            return
        }
        
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("Current user is \(self.currentUser)")
    }
}
