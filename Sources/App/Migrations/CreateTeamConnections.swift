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
            .field("userID", .uuid, .required)
            .field("teamID", .uuid, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("connections").delete()
    }
}
