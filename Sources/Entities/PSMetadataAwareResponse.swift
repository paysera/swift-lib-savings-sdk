import ObjectMapper

public class PSMetadataAwareResponse<T: Mappable>: Mappable {
 
    public var items: [T]?
    public var metaData: PSMetadata?
    
    private var itemsResponseKey: String {
        
        switch T.self {
        
        default:
            return ""
        }
    }
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        items       <- map[itemsResponseKey]
        metaData    <- map["_metadata"]
    }
}
