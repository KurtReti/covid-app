//
//  Singleton.swift
//  COVID-APP


import Foundation

struct Singleton {
    static var shared = Singleton()
    
    var UID: String?
    var accountID: String?
    var userType = "nil"

    private init() { }
}

