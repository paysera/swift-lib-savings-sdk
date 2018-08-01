//
//  PSCreateSavingsAccountRequest.swift
//  PayseraSavingsSDK
//
//  Created by Vytautas Gimbutas on 7/31/18.
//  Copyright © 2018 Paysera. All rights reserved.
//

import Foundation
import ObjectMapper

public class PSCreateSavingsAccountRequst: Mappable {
    public var type: String!
    public var accountNumber: String!
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        type          <- map["type"]
        accountNumber <- map["account_number"]
    }
}
