import ObjectMapper

public class PSAutomatedFillsFilter: Mappable {
    public var toAccountNumbers: [String]!
    
    public init() {}
    
    required public init?(map: Map) {    
    }
    
    public func mapping(map: Map) {
        toAccountNumbers <- map["to_account_numbers"]
    }
}
