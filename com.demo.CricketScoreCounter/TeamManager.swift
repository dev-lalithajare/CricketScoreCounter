/*
 
  Created by Lalit Hajare on 12/10/24 at 10:09 PM.

  MIT License
  
  Copyright (c) 2024 Lalit Hajare

  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE

*/

import Foundation

class TeamManager{
        
    private func createPlayer(playerName: String, teamName: String, seq: Int) -> Player{
        return Player(id: UUID().uuidString,
                      name: playerName,
                      team: teamName,
                      battingSequenceNumber: seq,
                      bowlingSequenceNumber: seq,
                      battingStatus: PlayerBattingStatus.PENDING,
                      bowlingStatus: PlayerBowlingStatus.PENDING
        )
    }
    
    func createTeamA() -> Team{
        var players: [Player] = []
        
        var player = createPlayer(playerName: "Sachin", teamName: "INDIA", seq: 1)
        players.append(player)
        
        player = createPlayer(playerName: "Virender", teamName: "INDIA", seq: 2)
        players.append(player)
        
        player = createPlayer(playerName: "Bhajji", teamName: "INDIA", seq: 3)
        players.append(player)
        
        player = createPlayer(playerName: "Yuvi", teamName: "INDIA", seq: 4)
        players.append(player)
        
        player = createPlayer(playerName: "Sunil", teamName: "INDIA", seq: 5)
        players.append(player)
        
        return Team(
                    teamName: "INDIA",
                    players: players,
                    battingSequence: getBattingSequence(players: players),
                    bowlingSequence: getBowlingSequence(players: players)
        )
    }
    
    func createTeamB() -> Team{
        var players: [Player] = []
        
        var player = createPlayer(playerName: "Christian", teamName: "AUSTRALIA", seq: 1)
        players.append(player)
        
        player = createPlayer(playerName: "Shane", teamName: "AUSTRALIA", seq: 2)
        players.append(player)
        
        player = createPlayer(playerName: "Charles", teamName: "AUSTRALIA", seq: 3)
        players.append(player)
        
        player = createPlayer(playerName: "Stephan", teamName: "AUSTRALIA", seq: 4)
        players.append(player)
        
        player = createPlayer(playerName: "Arnold", teamName: "AUSTRALIA", seq: 5)
        players.append(player)
        
        return Team(
                    teamName: "AUSTRALIA",
                    players: players,
                    battingSequence: getBattingSequence(players: players),
                    bowlingSequence: getBowlingSequence(players: players)
                )
    }
    
    func getBattingSequence(players: [Player]) -> [String: PlayerBattingStatus]{
        var battingSequence: [String: PlayerBattingStatus] = [:]
        let sortedPlayers = players.sorted(by: {$0.battingSequenceNumber < $1.battingSequenceNumber})
        for i in 0..<sortedPlayers.count {
            if(i == 0){
                battingSequence[sortedPlayers[i].id] = PlayerBattingStatus.ON_STRIKE
            }else if(i == 1){
                battingSequence[sortedPlayers[i].id] = PlayerBattingStatus.OFF_STRIKE
            }else{
                battingSequence[sortedPlayers[i].id] = PlayerBattingStatus.PENDING
            }
        }
        return battingSequence
    }

    func getBowlingSequence(players: [Player]) -> [String: PlayerBowlingStatus]{
        var bowlingSequence: [String: PlayerBowlingStatus] = [:]
        let sortedPlayers = players.sorted(by: {$0.bowlingSequenceNumber < $1.bowlingSequenceNumber})
        for i in 0..<sortedPlayers.count {
            if(i == 0){
                bowlingSequence[sortedPlayers[i].id] = PlayerBowlingStatus.BOWLING
            }else{
                bowlingSequence[sortedPlayers[i].id] = PlayerBowlingStatus.PENDING
            }
        }
        return bowlingSequence
    }
    
}
