//
//  AutomatedFill.swift
//  PayseraSavingsSDK
//
//  Created by Vytautas Gimbutas on 7/30/18.
//  Copyright © 2018 Paysera. All rights reserved.
//

import Foundation
import ObjectMapper

public class PSAutomatedFill: Mappable {
    public var id: String!
    public var amount: PSMoney!
    public var fromAccount: String!
    public var toAccount: String!
    public var period: PSAutomatedFillPeriod!
    public var createdBy: Int!
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        id          <- map["id"]
        amount      <- map["amount"]
        fromAccount <- map["from_account"]
        toAccount   <- map["to_account"]
        period      <- map["period"]
        createdBy   <- map["created_by"]
    }
}

public class PSAutomatedFillPeriod: Mappable {
    public var type: String!
    public var monthDay: String?
    public var weekDay: String?
    
    init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        type     <- map["type"]
        monthDay <- map["month_day"]
        weekDay  <- map["week_day"]
    }
}
