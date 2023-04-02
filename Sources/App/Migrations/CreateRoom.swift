//
//  CreateRoom.swift
//  
//
//  Created by Алиса Вышегородцева on 02.04.2023.
//

import Fluent

struct CreateRoom: AsyncMigration {
    
    func randInvintationCode(isPrivate: Bool) -> String? {
        if !isPrivate {
            let letters = "0123456789"
            return String((0..<10).map{ _ in letters.randomElement()! })
        }
        return nil
    }
    
    func prepare(on database: Database) async throws {
        try await database.schema("rooms")
            .id()
            .field("name", .string, .required)
            .field("adminId", .uuid, .required)
            .field("permissin", .bool, .required)
            .field("scorePerWord", .int8, .required)
            .field("invintationCode", .string, .custom(randInvintationCode(isPrivate: false)))
            .field("isGameStarted", .bool, .custom(false))
            .field("scoreToWin", .int8, .required)
            .field("roundTime", .double, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("rooms").delete()
    }
}
