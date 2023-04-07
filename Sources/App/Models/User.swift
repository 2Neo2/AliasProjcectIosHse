import Fluent
import Vapor

final class User: Model, Content, Authenticatable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "login")
    var login: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
//    func generateToken() throws -> Token {
//        try .init(value: [UInt8].random(count: 16).base64, userID: self.requireID())
//    }
    
    init() { }
    
    init(id: UUID? = nil, email: String, login: String, passwordHash: String) {
        self.id = id
        self.email = email
        self.login = login
        self.passwordHash = passwordHash
    }
}

extension User {
    struct Create: Content {
        var email: String
        var login: String
        var password: String
        var confirmPassword: String
    }
}

extension User.Create: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("login", as: String.self, is: .count(3...) && .alphanumeric)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

extension User: ModelAuthenticatable {
    static let usernameKey = \User.$email
    static let passwordHashKey = \User.$passwordHash

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}


//final class Token: Model, Content {
//    static let schema = "tokens"
//
//    @ID(key: .id)
//    var id: UUID?
//
//    @Field(key: "value")
//    var value: String
//
//    @Parent(key: "user_id")
//    var user: User
//
//    init() { }
//
//    init(id: UUID? = nil, value: String, userID: User.IDValue) {
//        self.id = id
//        self.value = value
//        self.$user.id = userID
//    }
//}
//
//extension Token: ModelTokenAuthenticatable {
//    static let valueKey = \Token.$value
//    static let userKey = \Token.$user
//    
//    var isValid: Bool { true }
//}
