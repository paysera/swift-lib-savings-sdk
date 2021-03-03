import ObjectMapper

public class PSCreateSavingsAccountRequest: Mappable {
    public var type: String?
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        type          <- map["type"]
    }
}
