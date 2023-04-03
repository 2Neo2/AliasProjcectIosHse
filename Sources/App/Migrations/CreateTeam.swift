//
//  File.swift
//  
//
//  Created by Иван Доронин on 03.04.2023.
//

import Fluent

struct CreateTeam: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("teams")
            .id()
            .field("name", .string, .required).unique(on: "name")
            .field("roomID", .uuid, .required, .references("rooms", "id"))
            .field("score", .int, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("teams").delete()
    }
}
