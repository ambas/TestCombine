//
//  Subscription.swift
//  TestCombine (iOS)
//
//  Created by Ambas Chobsanti on 11/7/21.
//

protocol Subscription: Cancellable {
    func request(_ demand: Subscribers.Demand)
}
