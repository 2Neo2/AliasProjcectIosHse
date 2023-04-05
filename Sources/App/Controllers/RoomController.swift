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
            room.get(use: getRoom)
        }
        
        rooms.group(":roomID") { room in
            room.delete(use: delete)
        }
        
        rooms.group(":roomID") { room in
            room.put(use: updateRoomSettings)
        }
    }
    
    // СRUD: Получение одной комнаты по id
    func getRoom(req: Request) async throws -> Room {
        guard let room = try await Room.find(req.parameters.get("roomID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return room
    }
    
    // СRUD: Получение всех комнат
    func index(req: Request) async throws -> [Room] {
        try await Room.query(on: req.db).all()
    }

    // СRUD: Создание комнаты
    func create(req: Request) async throws -> Room {
        let room = try req.content.decode(Room.self)
        try await room.save(on: req.db)
        return room
    }

    // СRUD: Удаление комнаты по id
    func delete(req: Request) async throws -> HTTPStatus {
        guard let room = try await Room.find(req.parameters.get("roomID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await room.delete(on: req.db)
        return .noContent
    }
    
    // СRUD: Обновление данных комнаты
    func updateRoomSettings(req: Request) async throws -> Room {
        let updateRoom = try req.content.decode(Room.self)
        guard let room = try await Room.find(req.parameters.get("roomID"), on: req.db) else {
            throw Abort(.notFound)
        }
        room.scoreToWin = updateRoom.scoreToWin
        room.scorePerWord = updateRoom.scorePerWord
        room.roundTime = updateRoom.roundTime
        try await room.save(on: req.db)
        return room
    }
}
