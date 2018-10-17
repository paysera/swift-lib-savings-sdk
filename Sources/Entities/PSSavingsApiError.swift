import Foundation
import ObjectMapper

public class PSSavingsApiError: Mappable, Error {
    public var error: String!
    public var description: String?
    public var properties: [String: Any]?
    public var errors: [PSSavingsApiFieldError]?
    
    init(error: String, description: String? = nil) {
        self.error = error
        self.description = description
    }
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        error       <- map["error"]
        errors      <- map["errors"]
        description <- map["error_description"]
        properties  <- map["error_properties"]
    }
    
    func isUnauthorized() -> Bool {
        return error == "unauthorized"
    }
    
    class func unknown() -> PSSavingsApiError {
        return PSSavingsApiError(error: "unknown")
    }
    
    class func unauthorized() -> PSSavingsApiError {
        return PSSavingsApiError(error: "unauthorized")
    }
}

public class PSSavingsApiFieldError: Mappable {
    public var code: String!
    public var field: String!
    public var message: String!
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        code    <- map["code"]
        field   <- map["field"]
        message <- map["message"]
    }
}
