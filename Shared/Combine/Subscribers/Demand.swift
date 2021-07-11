//
//  Demand.swift
//  TestCombine (iOS)
//
//  Created by Ambas Chobsanti on 11/7/21.
//

import Combine

extension Subscribers {
    
    struct Demand {
        
        private var value: UInt  = 0
        
        static var none: Demand { .init() }
        
        static var unlimited: Demand { .max(.max) }
        
        static func max(_ value: Int) -> Demand {
            // add precondition value can not be < 0
                .init(value: UInt(value))
        }
        
    }
}

extension Subscribers.Demand {
    static func +(_ lhs: Subscribers.Demand, _ rhs: Int) -> Subscribers.Demand {
        guard lhs != Subscribers.Demand.unlimited else {
            return lhs
        }
        return .max(Int(lhs.value) + rhs)
    }
    
    static func -(_ lhs: Subscribers.Demand, _ rhs: Int) -> Subscribers.Demand {
        guard lhs != Subscribers.Demand.unlimited else {
            return lhs
        }
        return .max(Int(lhs.value) - rhs)
    }
    
    static func +=(_ lhs: inout Subscribers.Demand, _ rhs: Int) {
        guard lhs != Subscribers.Demand.unlimited else {
            return
        }
        lhs = lhs + rhs
    }
    
    static func -=(_ lhs: inout Subscribers.Demand, _ rhs: Int) {
        guard lhs != Subscribers.Demand.unlimited else {
            return
        }
        lhs = lhs - rhs
    }
    
    static func +(_ lhs: Subscribers.Demand, _ rhs: Subscribers.Demand) -> Subscribers.Demand {
        return (lhs + Int(rhs.value))
    }
    
    static func +=(_ lhs: inout Subscribers.Demand, _ rhs: Subscribers.Demand) {
        lhs = lhs + rhs
    }
    
    static func -(_ lhs: Subscribers.Demand, _ rhs: Subscribers.Demand) -> Subscribers.Demand {
        return (lhs - Int(rhs.value))
    }
    
    static func -=(_ lhs: inout Subscribers.Demand, _ rhs: Subscribers.Demand) {
        lhs = lhs - rhs
    }
    
    static func >(_ lhs: Subscribers.Demand, rhs: Int) -> Bool {
        lhs.value > rhs
    }
    
    static func <(_ lhs: Subscribers.Demand, rhs: Int) -> Bool {
        lhs.value < rhs
    }
}

extension Subscribers.Demand: Equatable {
    
}
