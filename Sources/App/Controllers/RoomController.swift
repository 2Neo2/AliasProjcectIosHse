//
//  RoomController.swift
//  
//
//  Created by Алиса Вышегородцева on 02.04.2023.
//

import Fluent
import Vapor

struct RoomController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let rooms = routes.grouped("rooms")
        rooms.get(use: index)
        rooms.post(use: create)
        
        rooms.group(":roomID") { room in
            room.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Room] {
        try await Room.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Room {
        // Check if user in system.
        let room = try req.content.decode(Room.self)
        try await room.save(on: req.db)
        return room
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let room = try await Room.find(req.parameters.get("roomID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await room.delete(on: req.db)
        return .noContent
    }
}
