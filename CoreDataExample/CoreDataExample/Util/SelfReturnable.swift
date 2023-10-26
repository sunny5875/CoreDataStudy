//
//  SelfReturnable.swift
//  CoreDataStudy
//
//  Created by 현수빈 on 10/26/23.
//

import Foundation

protocol SelfReturnable {
    associatedtype ReturnType
    func with<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> ReturnType
}

extension SelfReturnable {
    func with<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
