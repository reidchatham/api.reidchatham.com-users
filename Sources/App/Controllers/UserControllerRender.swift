import Vapor
import FluentSQL
import Crypto

final class UserControllerRender {

    func renderRegister(_ req: Request) throws -> Future<View> {
        return try req.view().render("register")
    }

    // func register(_ req: Request) throws -> Future<Response> {
    //     // decode User from request data
    //     return try req.content.decode(User.self).flatMap { user in
    //         // query if user exists in database
    //         return User.query(on: req).filter(\User.email == user.email).first().flatMap { result in
    //             // if user exists redirect to registration
    //             if let _ = result {
    //                 return Future.map(on: req) {
    //                     return req.redirect(to: "/login")
    //                 }
    //             }
    //
    //             // if user does not exist save the hash of the password
    //             user.password = try BCryptDigest().hash(user.password)
    //
    //             // save the new user and redirect to login
    //             return user.save(on: req).map { _ in
    //                 return req.redirect(to: "/login")
    //             }
    //         }
    //     }
    // }

    func renderLogin(_ req: Request) throws -> Future<View> {
        // render the login view
        return try req.view().render("login")
    }

    // func login(_ req: Request) throws -> Future<Response> {
    //     return try req.content.decode(User.self).flatMap { user in
    //         return User.authenticate(
    //             username: user.email,
    //             password: user.password,
    //             using: BCryptDigest(),
    //             on: req
    //         ).map { user in
    //             guard let user = user else {
    //                 return req.redirect(to: "/login")
    //             }
    //
    //             try req.authenticateSession(user)
    //             return req.redirect(to: "/profile")
    //         }
    //     }
    // }

    func renderProfile(_ req: Request) throws -> Future<View> {
        let user = try req.requireAuthenticated(User.self)
        return try req.view().render("profile", ["user": user])
    }

    func logout(_ req: Request) throws -> Future<Response> {
        try req.unauthenticateSession(User.self)
        return Future.map(on: req) { return req.redirect(to: "/login") }
    }
}
