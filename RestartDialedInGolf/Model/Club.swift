//
//  Club.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation
import SwiftUI

struct Club: Codable, Equatable, CustomStringConvertible, Identifiable, Hashable {
    var description: String {
        return name
    }

    init(number: String, type: ClubType, name: String, distance: Int) {
        self.number = number
        self.type = type
        self.name = name
        self.distance = distance
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(number)
        hasher.combine(name)
        hasher.combine(swings)
        hasher.combine(id)
        hasher.combine(dateLastEdited)
    }

    private var number: String
    private var type: ClubType
    private var name: String
    private var distance: Int
    private var dateLastEdited: Date = Date()
    private var swings: [Swing] = [Swing]() {
        didSet {
            dateLastEdited = Date()
        }
    }
    var id = UUID()
    func getNumber() -> String {
        return number
    }

    func getName() -> String {
        return name
    }

    func getType() -> ClubType {
        return type
    }

    func getDistance() -> Int {
        return distance
    }
    
    func getAverageDistance() -> Int {
        var currSum = 0
        for swing in swings {
            currSum += swing.distance
        }
        return swings.count > 0 ? currSum / swings.count : 0
    }

    func getThreeFourthsDistance() -> Int {
        return Int(Double(getDistance()) * 0.75)
    }

    func getMaxDistance() -> Int {
        return Int(Double(getDistance()) * 1.25)
    }

    func getSwings(ofType: SwingDirection? = nil) -> [Swing] {
        if let ofType = ofType {
            return swings.filter({ $0.direction == ofType })
        }
        return swings
    }

    mutating func setNumber(_ n: String) {
        number = n
    }

    mutating func setName(_ n: String) {
        name = n
    }

    mutating func setType(_ n: ClubType) {
        type = n
    }

    mutating func setDistance(_ n: Int) {
        distance = n
    }

    mutating func setSwings(_ swings: [Swing]) {
        self.swings = swings
    }

    mutating func addSwing(_ swing: Swing) {
        swings.append(swing)
    }

    mutating func deleteSwing(_ swing: Swing) {
        swings.append(swing)
    }

    func getFIR() -> Double {
        let allFIRSwings = getSwings().filter {
            $0.wasGoingForFairway
        }
        let successSwings = getSwings().filter {
            $0.FIRSuccess == true
        }
        return Double(successSwings.count) / Double(allFIRSwings.count)
    }
    
    func getGIR() -> Double {
        let allFIRSwings = getSwings().filter {
            $0.wasGoingForGreen
        }
        let successSwings = getSwings().filter {
            $0.GIRSuccess == true
        }
        return Double(successSwings.count) / Double(allFIRSwings.count)
    }

    static func == (lhs: Club, rhs: Club) -> Bool {
        return lhs.number == rhs.number && lhs.type == rhs.type
    }
}
