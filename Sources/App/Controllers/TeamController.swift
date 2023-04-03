//
//  File.swift
//  
//
//  Created by Иван Доронин on 03.04.2023.
//

import Fluent
import Vapor

struct TeamController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let teams = routes.grouped("teams")
        teams.get(use: index)
        teams.post(use: create)
        
        teams.group(":teamID") { team in
            team.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Team] {
        try await Team.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Team {
        let team = try req.content.decode(Team.self)
        try await team.save(on: req.db)
        return team
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let team = try await Team.find(req.parameters.get("teamID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await team.delete(on: req.db)
        return .noContent
    }
}