import Foundation
import ObjectMapper
import PayseraCommonSDK

public class PSSavingsAccountFilter: PSBaseFilter {
    public var accountNumbers: [String]!
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        accountNumbers <- map["account_numbers"]
    }
}
