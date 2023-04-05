//
//  File.swift
//  
//
//  Created by Иван Доронин on 03.04.2023.
//

import Fluent
import Vapor


final class Team: Model, Content {
    static let schema = "teams"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "roomID")
    var roomID: UUID?
    
    @Field(key: "score")
    var score: Double
    
    init() {}
    
    init(id: UUID? = nil, name: String, roomID: UUID? = nil, score: Double) {
        self.id = id
        self.name = name
        self.roomID = roomID
        self.score = score
    }
    
}
