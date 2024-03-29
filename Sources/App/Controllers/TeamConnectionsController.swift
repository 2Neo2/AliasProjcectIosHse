//
//  File.swift
//  
//
//  Created by Иван Доронин on 31.03.2023.
//

import Fluent
import Vapor

struct TeamConnectionsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let connections = routes.grouped("connections")
        connections.get(use: index)
        connections.post(use: create)
        
        connections.group(":connectionID") { connect in
            connect.get(use: getConnection)
        }
        
        connections.group(":connectionID") { connect in
            connect.delete(use: delete)
        }
    }
    
    // СRUD: Получение одного коннекшна по id
    func getConnection(req: Request) async throws -> TeamConnection {
        guard let connect = try await
                TeamConnection.find(req.parameters.get("connectionID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return connect
    }
    
    // СRUD: Получение всех коннекшнов
    func index(req: Request) async throws -> [TeamConnection] {
        try await TeamConnection.query(on: req.db).all()
    }

    // СRUD: Создание коннекшна
    func create(req: Request) async throws -> TeamConnection {
        let connection = try req.content.decode(TeamConnection.self)
        try await connection.save(on: req.db)
        return connection
    }

    // СRUD: Удаление одного коннекшна по id
    func delete(req: Request) async throws -> HTTPStatus {
        guard let connect = try await
                TeamConnection.find(req.parameters.get("connectionID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await connect.delete(on: req.db)
        return .noContent
    }
}
