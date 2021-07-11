//
//  Combine.swift
//  TestCombine (iOS)
//
//  Created by Ambas Chobsanti on 11/7/21.
//

import Foundation

protocol Publisher {
    associatedtype Output
    associatedtype Failure: Error
    
    func receive<S: Subscriber>(_ subscriber: S) where S.Input == Output, S.Failure == Failure
}

protocol Subject: Publisher {
    func send(_ value: Output)
    func send(_ complete: Subscribers.Complete<Failure>)
}

protocol Subscriber {
    associatedtype Input
    associatedtype Failure: Error
    
    
    func receive(_ input: Input) -> Subscribers.Demand
    func receive(_ completion: Subscribers.Complete<Failure>)
    func receive(_ subscribtion: Subscription)
}

enum Subscribers {}

extension Subscribers {
    enum Complete<Failure: Error> {
        case finished
        case failure(Failure)
    }
}

enum CurrentValueSubjectError: Error {
    case a
}
