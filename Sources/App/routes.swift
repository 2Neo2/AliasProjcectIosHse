import Fluent
import Vapor

func routes(_ app: Application) throws {
    //    app.get { req async in
    //        "It works!"
    //    }
    //
    //    app.get("hello") { req async -> String in
    //        "Hello, world!"
    //    }
    
    try app.register(collection: UserController())
    try app.register(collection: RoomController())
    try app.register(collection: TeamController())
    try app.register(collection: TeamConnectionsController())
    
    
    let passwordProtected = app
        .grouped(User.authenticator())
    passwordProtected.post("login") { req -> User in
        try req.auth.require(User.self)
    }
    
//    
//    let tokenProtected = app.grouped(Token.authenticator())
//    tokenProtected.get("me") { req -> User in
//        try req.auth.require(User.self)
//    }
}
