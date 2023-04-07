//
//  CreateToken.swift
//  
//
//  Created by Алиса Вышегородцева on 07.04.2023.
//

import Fluent

struct CreateToken: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("tokens")
            .id()
            .field("value", .string, .required)
            .field("user_id", .int, .required, .references("users", "id"))
            .unique(on: "value")
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("tokens").delete()
    }
}

