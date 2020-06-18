//
//  User+Authentication.swift
//  APIErrorMiddleware
//
//  Created by Reid Chatham on 1/1/20.
//

import Vapor
import Authentication

extension User: PasswordAuthenticatable {
//    static var usernameKey: WritableKeyPath<User, String> {
//        return \User.email
//    }
    static var passwordKey: WritableKeyPath<User, String> {
        return \User.password
    }
}

extension User: SessionAuthenticatable {}
