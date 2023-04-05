//
//  Room.swift
//  
//
//  Created by Алиса Вышегородцева on 02.04.2023.
//

import Fluent
import Vapor

final class Room: Model, Content {
    static let schema = "rooms"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "adminId")
    var adminId: UUID
    
    @Field(key: "permission")
    var permission: Bool
    
    @Field(key: "scorePerWord")
    var scorePerWord: Double
    
    @Field(key: "invintationCode")
    var invintationCode: String?
    
    @Field(key: "isGameStarted")
    var isGameStarted: Bool
    
    @Field(key: "scoreToWin")
    var scoreToWin: Double
    
    @Field(key: "roundTime")
    var roundTime: Double
    
    init() { }
    
    init(id: UUID? = nil, name: String, adminId: UUID, permission: Bool, scorePerWord: Double, invintationCode: String? = nil, isGameStarted: Bool = false, scoreToWin: Double, roundTime: Double) {
        self.id = id
        self.name = name
        self.adminId = adminId
        self.permission = permission
        self.scorePerWord = scorePerWord
        self.invintationCode = invintationCode
        self.isGameStarted = isGameStarted
        self.scoreToWin = scoreToWin
        self.roundTime = roundTime
    }
}

