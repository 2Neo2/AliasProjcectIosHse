//
//  CreateRoom.swift
//  
//
//  Created by Алиса Вышегородцева on 02.04.2023.
//

import Fluent

struct CreateRoom: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("rooms")
            .id()
            .field("name", .string, .required).unique(on: "name")
            .field("adminId", .uuid, .required, .references("users", "id"))
            .field("permission", .bool, .required)
            .field("scorePerWord", .int8, .required)
            .field("invintationCode", .string)
            .field("isGameStarted", .bool)
            .field("scoreToWin", .int8, .required)
            .field("roundTime", .double, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("rooms").delete()
    }
}
