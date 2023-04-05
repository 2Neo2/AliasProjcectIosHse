import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: index)
        users.post(use: create)
        
        users.group(":userID") { user in
            user.get(use: getUser)
        }
        
        users.group(":userID") { user in
            user.delete(use: delete)
        }
    }
    
    // СRUD: Получение одного юзера по id
    func getUser(req: Request) async throws -> User {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return user
    }
    
    // СRUD: Получение всех юзеров
    func index(req: Request) async throws -> [User] {
        try await User.query(on: req.db).all()
    }

    // СRUD: Создание юзера
    func create(req: Request) async throws -> User {
        let user = try req.content.decode(User.self)
        try await user.save(on: req.db)
        return user
    }

    // СRUD: Удаление одного юзера по id
    func delete(req: Request) async throws -> HTTPStatus {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db)
        return .noContent
    }
}
