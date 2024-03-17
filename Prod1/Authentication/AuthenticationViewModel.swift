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
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: userObject?
    
    init() {
        self.userSession = Auth.auth().currentUser // user session = authenticated current user
        
        Task {
            await fetchUser() // fetches current users data
        }
    }
    
    func fetchUser() async {
        guard let currentUserId = Auth.auth().currentUser?.uid // collects current user ID from firebase
        else {
            return
        }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(currentUserId).getDocument() // creates a snapshot of the current user data from firestore database
        else {
            return
        }
        
        self.currentUser = try? snapshot.data(as: userObject.self) // currentUser = data from snapshot in the structure of the userObject
        
        print("Current user is \(self.currentUser)")
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password) // signs into the authenticated user from firebase
            self.userSession = result.user // user session = authenticated user
            await fetchUser() // fetches the authenticated users data
        } catch {
            print("LOG IN Failed... \(error.localizedDescription)")
        }
    }
    
    func signUp(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password) // Authenticates user
            self.userSession = result.user // user session = authenticated user
            let user = userObject(id: result.user.uid, fullname: fullname, email: email) // initializes the raw data for encoding
            let encodedUser = try Firestore.Encoder().encode(user) // encodes raw data to encrypted data
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser) // adds encrypted data to firestore database
            await fetchUser() // fetches this data from firebase
        } catch {
            print("SIGN UP Failed... \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // firebase sign out
            self.userSession = nil // takes us back to login screen
            self.currentUser = nil // stops old data from appearing when logged into new user
        } catch {
            print("SIGNED OUT Failed... \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        print("ACCOUNT DELETED")
    }
}
