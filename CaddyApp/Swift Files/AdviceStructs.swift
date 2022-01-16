//
//  AdviceStruct.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/17/21.
//

import Foundation

struct Advice {
    var closestClubBelow: ClubObject = ClubObject(name: "", type: "", fullDistance: 0, threeFourthsDistance: 0, maxDistance: 0, averageFullDistance: 0, previousFullHits: "")

    var clubBelowDistance: Int = 0
    var clubBelowGap: Int = 0
    var clubAboveGap: Int = 0
    var clubAboveDistance: Int = 0
    var closestClubAbove: ClubObject = ClubObject(name: "", type: "", fullDistance: 0, threeFourthsDistance: 0, maxDistance: 0, averageFullDistance: 0, previousFullHits: "")
    var secondclosestClubDistance: Int = 0
    var secondClosestClubGap: Int = 0
    var flagColor: String = "Red"
    
    var lieType: String = "SideHillDown"

    var distanceToPin = 0
}

struct ClosestClubBelow {
    var gap = 999
    var clubName = ""
    var swingType: swingTypeState
}
