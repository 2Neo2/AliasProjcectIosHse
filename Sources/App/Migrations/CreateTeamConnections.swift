//
//  File.swift
//  
//
//  Created by Иван Доронин on 31.03.2023.
//

import Fluent

struct CreateTeamConnections: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("connections")
            .id()
            .field("userID", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("teamID", .uuid, .required, .references("teams", "id", onDelete: .cascade))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("connections").delete()
    }
}
