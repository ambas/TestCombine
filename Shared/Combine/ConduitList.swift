//
//  ConduitList.swift
//  TestCombine (iOS)
//
//  Created by Ambas Chobsanti on 11/7/21.
//

import Foundation

enum ConduitList<Output, Failure: Error> {
    case empty
    case single(ConduitBase<Output, Failure>)
    case many(Set<ConduitBase<Output, Failure>>)
}

extension ConduitList {
    mutating func insert(_ conduit: ConduitBase<Output, Failure>) {
        switch self {
        case .empty:
            self = .single(conduit)
        case .single(conduit):
            break
        case .single(let singleConduit):
            self = .many([singleConduit, conduit])
        case .many(var conduitList):
            conduitList.insert(conduit)
        }
    }
    
    var conduits: Set<ConduitBase<Output, Failure>> {
        get {
            switch self {
            case .empty:
                return []
            case .single(let conduit):
                return [conduit]
            case .many(let conduitSet):
                return conduitSet
            }
        }
        set {
            if newValue.count == 1, let singleConduit = newValue.first {
                self = .single(singleConduit)
            } else if newValue.count > 1 {
                self = .many(newValue)
            } else {
                self = .empty
            }
        }
    }
    
    func forEach(_ body: (ConduitBase<Output, Failure>) throws -> Void ) rethrows {
        try conduits.forEach(body)
    }
    
    mutating func remove(_ conduit: ConduitBase<Output, Failure>) {
        var newConduits = conduits
        newConduits.remove(conduit)
        conduits = newConduits
        
    }
}

