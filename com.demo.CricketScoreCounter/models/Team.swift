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
