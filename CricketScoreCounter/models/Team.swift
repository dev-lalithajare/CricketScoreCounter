//
//  Team.swift
//  CricketScoreCounter
//
//  Created by Lalit Hajare on 21/09/24.
//

import Foundation

struct Team{
    let teamName: String
    let players: [Player]
    var battingSequence: [String: PlayerBattingStatus]
    var bowlingSequence: [String: PlayerBowlingStatus]
    
    func getCurrentBastmanOnStrike() -> Player?{
        for player in players{
            if battingSequence[player.id] == PlayerBattingStatus.ON_STRIKE {
                return player
            }
        }
        return nil
    }
    
    func getCurrentBastmanOffStrike() -> Player?{
        for player in players{
            if battingSequence[player.id] == PlayerBattingStatus.OFF_STRIKE {
                return player
            }
        }
        return nil
    }
    
    func getCurrentBowler() -> Player?{
        for player in players{
            if bowlingSequence[player.id] == PlayerBowlingStatus.BOWLING {
                return player
            }
        }
        return nil
    }
    
    func getNextBatsman() -> Player?{
        for player in players{
            if battingSequence[player.id] == PlayerBattingStatus.PENDING {
                return player
            }
        }
        return nil
    }
    
    func getNextBolwer() -> Player?{
        for player in players{
            if bowlingSequence[player.id] == PlayerBowlingStatus.PENDING {
                return player
            }
        }
        return nil
    }
}
