//
//  CurrentValueSubject.swift
//  TestCombine (iOS)
//
//  Created by Ambas Chobsanti on 11/7/21.
//

class CurrentValueSubject<Output, Failure: Error>: Subject {
    
    private var condiuts = ConduitList<Output, Failure>.empty
    
    private var currentValue: Output
    var value: Output {
        get {
            return currentValue
        }
        set {
            currentValue = newValue
            condiuts.forEach {
                $0.offer(self.currentValue)
            }
        }
    }
    
    init(_ value: Output) {
        self.currentValue = value
    }
    
    func send(_ complete: Subscribers.Complete<Failure>) {
        condiuts.forEach {
            $0.finish(completion: complete)
        }
    }
    
    func send(_ value: Output) {
        self.value = value
    }
    
    func receive<S>(_ subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = Conduit(downstream: subscriber, parent: self)
        condiuts.insert(subscription)
        subscriber.receive(subscription)
    }
    
    func disassociative<S: Subscriber>(_ conduit: Conduit<S>) where S.Input == Output, S.Failure == Failure {
        condiuts.remove(conduit)
    }
}

extension CurrentValueSubject {
    final class Conduit<Downstream: Subscriber>: ConduitBase<Output, Failure> where Downstream.Input == Output, Downstream.Failure == Failure {
        private var downstream: Downstream?
        private var demand = Subscribers.Demand.none
        private weak var parent: CurrentValueSubject?
        
        init(downstream: Downstream, parent: CurrentValueSubject)  {
            self.downstream = downstream
            self.parent = parent
        }
        
        override func offer(_ output: Output) {
            guard demand > 0, let downstream = self.downstream else { return }
            demand -= 1
            let newDemand = downstream.receive(output)
            demand += newDemand
        }
        
        override func finish(completion: Subscribers.Complete<Failure>) {
            downstream?.receive(completion)
        }
        
        override func request(_ demand: Subscribers.Demand) {
            self.demand = demand
        }
        
        override func cancel() {
            guard self.downstream != nil else {
                return
            }
            self.downstream = nil
            parent?.disassociative(self)
            parent = nil
        }
        
    }
}
