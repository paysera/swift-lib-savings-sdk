//
//  PSSavingsAccount.swift
//  PayseraSavingsSDK
//
//  Created by Vytautas Gimbutas on 7/31/18.
//  Copyright © 2018 Paysera. All rights reserved.
//

import Foundation
import ObjectMapper

public class PSSavingsAccount: Mappable {
    public var id: String!
    public var type: String!
    public var accountNumber: String!
    public var goal: PSSavingsAccountGoal?
    
    public init() {}
    
    required public init?(map: Map) {   
    }
    
    public func mapping(map: Map) {
        id            <- map["id"]
        type          <- map["type"]
        accountNumber <- map["account_number"]
        goal          <- map["goal"]
    }
}

public class PSSavingsAccountGoal: Mappable {
    public var amount: PSMoney?
    public var dateUntil: Date?
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        amount    <- map["amount"]
        dateUntil <- map["date_until"]
    }
}
