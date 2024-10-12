//
//  TeamStats.swift
//  CricketScoreCounter
//
//  Created by Lalit Hajare on 21/09/24.
//

import Foundation

struct TeamStats{
    let teamName: String
    let totalRuns: Int
    let totalFours: Int
    let totalSixes: Int
    let batsmen: [Batsman]
    let totalWickets: Int
    let totalOvers: Int
    let totalWides: Int
    let totalNoBalls: Int
    let bowlers: [Bowler]
}
