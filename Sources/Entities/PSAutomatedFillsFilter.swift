//
//  PSAutomatedFillsFilter.swift
//  PayseraSavingsSDK
//
//  Created by Vytautas Gimbutas on 7/31/18.
//  Copyright © 2018 Paysera. All rights reserved.
//

import Foundation
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
