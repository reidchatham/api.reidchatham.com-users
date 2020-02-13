import Vapor
import Authentication
import JWTMiddleware

/// Register your application's routes here.
public func routes(
    _ router: Router,
    _ container: Container
) throws {
  print("set routes")
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }

    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }


    let userController = UserControllerRender()
    if openRegistration {
        router.get("register", use: userController.renderRegister)
    } else {
        let restricted = router.grouped(PermissionsMiddleware<Payload>(allowed: [.admin]))
        restricted.get("register", use: userController.renderRegister)
    }
    // router.post("register", use: userController.register)
    router.get("login", use: userController.renderLogin)

    let authSessionRouter = router.grouped(User.authSessionsMiddleware())
    // authSessionRouter.post("login", use: userController.login)

    let protectedRouter = authSessionRouter.grouped(RedirectMiddleware<User>(path: "/login"))
    protectedRouter.get("profile", use: userController.renderProfile)

    router.get("logout", use: userController.logout)

    //-----------------------------------------------------------------------//

//    let root = router.grouped(any, "users")
    let root = router.grouped("users")

    // Create a 'health' route useed by AWS to check if the server needs a re-boot.
    root.get("health") { _ in
        return "all good"
    }

    let jwtService = try container.make(JWTService.self)

    try root.register(collection: AdminController())
    try root.register(collection: AuthController(jwtService: jwtService))
    try root.grouped(JWTAuthenticatableMiddleware<User>()).register(collection: UserController())
}
