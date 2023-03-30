import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "email")
    var email: String
    
    @Field(key: "login")
    var login: String
    
    @Field(key: "password")
    var password: String
    
    init() { }

    init(id: UUID? = nil, email: String, login: String, password: String) {
        self.id = id
        self.email = email
        self.login = login
        self.password = password
    }
}
