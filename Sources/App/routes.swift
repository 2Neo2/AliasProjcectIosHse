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
    try app.register(collection: TeamConnectionsController())
    try app.register(collection: TeamController())
}
