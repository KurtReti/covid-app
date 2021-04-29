//
//  SessionStore.swift
//  COVID-APP
//
//  Created by Connor Jones on 7/4/21.
//


import SwiftUI
import Firebase
import Combine

class SessionStore : ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    
    func signIn(
            email: String,
            password: String,
            handler: @escaping AuthDataResultCallback
            ) {
            Auth.auth().signIn(withEmail: email, password: password, completion: handler)
        }
    
    
    
    func unbind () {
            if let handle = handle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }

    // additional methods (sign up, sign in) will go here
}


class User {
    var uid: String
    var email: String?
    var displayName: String?

    init() {
        self.uid = "0"
    }
    init(uid: String, displayName: String?) {
        self.uid = uid
        //
        self.displayName = displayName
    }
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
    
    func getUID() -> String {
        
        return self.uid
    }

}
