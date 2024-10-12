//
//  Player.swift
//  CricketScoreCounter
//
//  Created by Lalit Hajare on 20/09/24.
//

import Foundation

enum PlayerBattingStatus{
    case PENDING    
    case ON_STRIKE
    case OFF_STRIKE
    case OUT
}

enum PlayerBowlingStatus{
    case PENDING
    case BOWLING
    case OVERS_FINISHED
}

struct Player{
    let id: String
    let name: String
    let team: String
    let battingSequenceNumber: Int
    let bowlingSequenceNumber: Int
    var battingStatus: PlayerBattingStatus
    var bowlingStatus: PlayerBowlingStatus
}
