//
//  PSSavingsAccountFilter.swift
//  PayseraSavingsSDK
//
//  Created by Vytautas Gimbutas on 7/31/18.
//  Copyright © 2018 Paysera. All rights reserved.
//

import Foundation
import ObjectMapper

public class PSSavingsAccountFilter: Mappable {
    public var accountNumbers: [String]!
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        accountNumbers <- map["account_numbers"]
    }
}
