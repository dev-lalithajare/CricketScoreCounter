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

class Printer{
    
    func printStatsForDelivery(deliveryStats: DeliveryStats){
        print("------------------------------------------------------------------------------")
        print("On-strike: \(deliveryStats.onStrikeBatsmanName) (\(deliveryStats.onStrikeBatsmanRuns))"+"\t\t Off-strike: \(deliveryStats.offStrikeBatsmanName) (\(deliveryStats.offStrikeBatsmanRuns))\t\t Balls: \(deliveryStats.numberOfDeliveriesInOver)")
    }
    
    func printStatsForOver(overStats: OverStats){
        print("------------------------------------------------------------------------------")
        print("TOTAL SCORE: \(overStats.totalScore) \t OVERS: \(overStats.numberOfOvers) \t WICKETS: \(overStats.wickets)"+"\n RUNS IN THIS OVER: \(overStats.runsScoredInOver)")
    }
    
    func printStatsForInnings(inningStats: InningStats){
        print("\n-------------------------------------------------------------------------------")
        print("INNINGS FINISHED\n")
        print("\(inningStats.battingTeamName) (BATTING)")
        for batsman in inningStats.batsmen {
            print("\(batsman.name)  -   \(batsman.runs)     (\(batsman.sixes) sixes, \(batsman.fours) fours)")
        }
        print("\n")
        print("\(inningStats.bowlingTeamName) (BOWLING): \t\t TARGET: \(inningStats.target)")
        for bowler in inningStats.bowlers {
            print("\(bowler.name)  -   \(bowler.overs)     (\(bowler.wides) wides, \(bowler.nos) nos, \(bowler.wickets) wickets)")
        }
        print("-------------------------------------------------------------------------------\n\n")
    }
    
    func printStatsForMatch(matchStats: MatchStats){
        print("------------------------------- MATCH FINISHED --------------------------------")
        print("WINNING TEAM:\t\t >>>>>>>>>>>>> \(matchStats.winningTeamName) <<<<<<<<<<<<<<")
        
        print("\n\(matchStats.teamAStats.teamName) -")
        print("--------------------------")
        print("BATTING:\n")
        print("TOTAL RUNS\t-\t\(matchStats.teamAStats.totalRuns)")
        print("TOTAL FOURS\t-\t\(matchStats.teamAStats.totalFours)")
        print("TOTAL SIXES\t-\t\(matchStats.teamAStats.totalSixes)")
        print("\n")
        for batsman in matchStats.teamAStats.batsmen {
            print("\(batsman.name)  -   \(batsman.runs)     (\(batsman.sixes) sixes, \(batsman.fours) fours)")
        }
        print("\n\n")
        print("BOWLING:")
        print("TOTAL WICKETS\t-\t\(matchStats.teamAStats.totalWickets)")
        print("TOTAL OVERS\t-\t\(matchStats.teamAStats.totalOvers)")
        print("TOTAL WIDES\t-\t\(matchStats.teamAStats.totalWides)")
        print("TOTAL NO BALLS\t-\t\(matchStats.teamAStats.totalNoBalls)")
        print("\n")
        for bowler in matchStats.teamAStats.bowlers {
            print("\(bowler.name)  -   \(bowler.overs)     (\(bowler.wides) wides, \(bowler.nos) nos, \(bowler.wickets) wickets)")
        }
        
        print("##############################################################################")
        
        print("\(matchStats.teamBStats.teamName) -")
        print("--------------------------")
        print("BATTING:")
        print("TOTAL RUNS\t-\t\(matchStats.teamBStats.totalRuns)")
        print("TOTAL FOURS\t-\t\(matchStats.teamBStats.totalFours)")
        print("TOTAL SIXES\t-\t\(matchStats.teamBStats.totalSixes)")
        print("\n")
        for batsman in matchStats.teamBStats.batsmen {
            print("\(batsman.name)  -   \(batsman.runs)     (\(batsman.sixes) sixes, \(batsman.fours) fours)")
        }
        print("\n")
        print("BOWLING:")
        print("TOTAL WICKETS\t-\t\(matchStats.teamBStats.totalWickets)")
        print("TOTAL OVERS\t-\t\(matchStats.teamBStats.totalOvers)")
        print("TOTAL WIDES\t-\t\(matchStats.teamBStats.totalWides)")
        print("TOTAL NO BALLS\t-\t\(matchStats.teamBStats.totalNoBalls)")
        print("\n")
        for bowler in matchStats.teamBStats.bowlers {
            print("\(bowler.name)  -   \(bowler.overs)     (\(bowler.wides) wides, \(bowler.nos) nos, \(bowler.wickets) wickets)")
        }
        
        print("------------------------------- MATCH FINISHED --------------------------------")
    }
    
}
