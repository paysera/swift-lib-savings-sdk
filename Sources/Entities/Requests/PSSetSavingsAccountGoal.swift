import Foundation
import ObjectMapper
import PayseraCommonSDK

public class PSSetSavingsAccountGoal: Mappable {
    public var amount: PSMoney?
    public var dateUntil: Date?
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        amount    <- map["amount"]
        dateUntil <- (map["date_until"], DateTransform())
    }
}
