//
//  ConduitBase.swift
//  TestCombine (iOS)
//
//  Created by Ambas Chobsanti on 11/7/21.
//

import Foundation

class ConduitBase<Output, Failure: Error>: Subscription {
    
    func offer(_ output: Output) {
        
    }
    
    func finish(completion: Subscribers.Complete<Failure>) {
        
    }
    
    func request(_ demand: Subscribers.Demand) {
        
    }
    
    func cancel() {
        
    }
}

extension ConduitBase: Hashable {
    static func == (lhs: ConduitBase<Output, Failure>, rhs: ConduitBase<Output, Failure>) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
