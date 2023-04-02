//
//  File.swift
//  
//
//  Created by Иван Доронин on 31.03.2023.
//

import Fluent
import Vapor

final class TeamConnection: Model, Content {
    static let schema = "connections"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "userID")
    var userID: UUID?
    
    @Field(key: "teamID")
    var teamID: UUID?
    
    init() { }
    
    init(id: UUID? = nil, userID: UUID? = nil, teamID: UUID? = nil) {
        self.id = id
        self.userID = userID
        self.teamID = teamID
    }
}
