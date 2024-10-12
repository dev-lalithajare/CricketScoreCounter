//
//  ScoreKeeper.swift
//  CricketScoreCounter
//
//  Created by Lalit Hajare on 06/10/24.
//

import Foundation

class ScoreKeeper{
    
    private let teamManager = TeamManager()
    private let printer = Printer()
    private var firstInnings = Innings(inningNumber: 1)
    private var secondInnings = Innings(inningNumber: 2)
    private var currentInnings: Innings
    
    init(){
        let teamA = teamManager.createTeamA()
        let teamB = teamManager.createTeamB()
        currentInnings = firstInnings
        setTeams(teamA: teamA, teamB: teamB)
    }
    
    func takeInputForDelivery(){
        print("\nEnter type of Ball: V - Valid, W - wide, N - No, O - Out")
        let strBallType = readLine()!
        let ballType = getBallType(ballType: strBallType)
        var graceRuns: Int = 0
        var runs: Int = 0
        
        if(ballType == BallType.WIDE){
            graceRuns = 1
        }else if(ballType == BallType.OUT){
            runs = 0
        }else{
            print("Enter number of runs scored: 1, 2, 3, 4, 6")
            runs = Int(readLine()!)!
            if(ballType == BallType.NO){
                graceRuns = 1
            }
        }
        
        let delivery = Delivery(
            ballType: ballType,
            runsScored: runs + graceRuns,
            batsmanId: currentInnings.currentBattingTeam!.getCurrentBastmanOnStrike()!.id,
            bowlerId: currentInnings.currentBowlingTeam!.getCurrentBowler()!.id,
            isFirstDeliveryInOver: isFirstDeliveryInOver(ballType: ballType)
        )
        addDelivery(delivery: delivery)
        if ((runs == 1 || runs == 3) && ballType != BallType.WIDE) {
            swapBatsman()
        }
        printer.printStatsForDelivery(deliveryStats: getDeliveryStats())
        
        if(ballType == BallType.OUT){
            if(currentInnings.getTotalWickets() < (currentInnings.currentBattingTeam!.battingSequence.count - 1)){
                currentInnings.onBatsmanOut()
            }else{
                onMatchFinished()
            }
        }
        
        if(currentInnings.checkOverCounter()){
            printer.printStatsForOver(overStats: getOverStats())
            swapBatsman()
        }
    }
    
    func addDelivery(delivery: Delivery){
        if(delivery.ballType == BallType.OUT){
            currentInnings.currentBattingTeam?.battingSequence[delivery.batsmanId] = PlayerBattingStatus.OUT
            let nextPlayerKey = currentInnings.currentBattingTeam?.battingSequence.first{
                $0.value == PlayerBattingStatus.PENDING
            }?.key
            currentInnings.currentBattingTeam?.battingSequence[nextPlayerKey!] = PlayerBattingStatus.ON_STRIKE
        }
        currentInnings.deliveries.append(delivery)
    }

    
    func swapBatsman(){
        let onStrikeBatsmanKey = currentInnings.currentBattingTeam?.battingSequence.first{
            $0.value == PlayerBattingStatus.ON_STRIKE
        }?.key
        
        let offStrikeBatsmanKey = currentInnings.currentBattingTeam?.battingSequence.first{
            $0.value == PlayerBattingStatus.OFF_STRIKE
        }?.key
        
        currentInnings.currentBattingTeam?.battingSequence[onStrikeBatsmanKey!] = PlayerBattingStatus.OFF_STRIKE
        currentInnings.currentBattingTeam?.battingSequence[offStrikeBatsmanKey!] = PlayerBattingStatus.ON_STRIKE
    }
    
    func getNumberOfDeliveriesForFirstInnings() -> Int {
        firstInnings.getNumberOfDeliveries()
    }
    
    func getNumberOfDeliveriesForSecondInnings() -> Int {
        secondInnings.getNumberOfDeliveries()
    }
    
    private func isFirstDeliveryInOver(ballType: BallType) -> Bool{
        if(ballType == BallType.VALID || ballType == BallType.OUT){
            if (!currentInnings.hasAnyValidDelivery() || currentInnings.deliveries.count % 6 == 0) {
                return true
            }
        }
        return false
    }
    
    private func getBallType(ballType: String) -> BallType{
        switch(ballType){
            case "V": BallType.VALID
            case "W": BallType.WIDE
            case "N": BallType.NO
            case "O": BallType.OUT
            default: BallType.VALID
        }
    }
    
    func setTeams(teamA: Team, teamB: Team){
        firstInnings.setTeams(teamA: teamA, teamB: teamB)
    }
    
    func onInningsFinished(){
        printer.printStatsForInnings(inningStats: getInningsStats())
        currentInnings = secondInnings
        currentInnings.currentBattingTeam = firstInnings.currentBowlingTeam
        currentInnings.currentBowlingTeam = firstInnings.currentBattingTeam
        currentInnings.target = firstInnings.getTotalScore()
    }
    
    func onMatchFinished(){
        printer.printStatsForMatch(matchStats: getMatchStats())
    }
    
    func getMatchStats() -> MatchStats{
        return MatchStats(
            winningTeamName: getWinningTeamName(),
            teamAStats: getTeamAStats(),
            teamBStats: getTeamBStats()
        )
    }
    
    private func getWinningTeamName() -> String{
        if(firstInnings.getTotalScore() > secondInnings.getTotalScore()){
            return firstInnings.currentBattingTeam!.teamName
        }else if(firstInnings.getTotalScore() == secondInnings.getTotalScore()){
            return "DRAW"
        }else{
            return secondInnings.currentBattingTeam!.teamName
        }
    }
    
    private func getTeamAStats() -> TeamStats{
        let team = firstInnings.currentBattingTeam!
        return TeamStats(
            teamName: team.teamName,
            totalRuns: firstInnings.getTotalScore(),
            totalFours: firstInnings.getTotalFours(),
            totalSixes: firstInnings.getTotalSixes(),
            batsmen: firstInnings.prepareBatsmanData(),
            totalWickets: secondInnings.getTotalWickets(),
            totalOvers: secondInnings.oversCounter,
            totalWides: secondInnings.getTotalWides(),
            totalNoBalls: secondInnings.getTotalNos(),
            bowlers: secondInnings.prepareBowlerData()
        )
    }
    
    private func getTeamBStats() -> TeamStats{
        let team = secondInnings.currentBattingTeam!
        return TeamStats(
            teamName: team.teamName,
            totalRuns: secondInnings.getTotalScore(),
            totalFours: secondInnings.getTotalFours(),
            totalSixes: secondInnings.getTotalSixes(),
            batsmen: secondInnings.prepareBatsmanData(),
            totalWickets: firstInnings.getTotalWickets(),
            totalOvers: firstInnings.oversCounter,
            totalWides: firstInnings.getTotalWides(),
            totalNoBalls: firstInnings.getTotalNos(),
            bowlers: firstInnings.prepareBowlerData()
        )
    }
    
    
    func getInningsStats() -> InningStats{
        return InningStats(
            battingTeamName: currentInnings.currentBattingTeam!.teamName,
            bowlingTeamName: currentInnings.currentBowlingTeam!.teamName,
            target: currentInnings.getTotalScore(),
            batsmen: currentInnings.prepareBatsmanData(),
            bowlers: currentInnings.prepareBowlerData()
        )
    }
    
    func getOverStats() -> OverStats{
        return OverStats(
            totalScore: currentInnings.getTotalScore(),
            runsScoredInOver: currentInnings.getRunsInOver(),
            wickets: currentInnings.getTotalWickets(),
            target: secondInnings.target,
            numberOfOvers: currentInnings.getTotalNumberOfOversFinished()
        )
    }
    
    func getDeliveryStats() -> DeliveryStats{
        return DeliveryStats(
            bowlerName: currentInnings.getBowlerName(),
            onStrikeBatsmanName: currentInnings.getOnStrikeBatsmanName(),
            offStrikeBatsmanName: currentInnings.getOffStrikeBatsmanName(),
            onStrikeBatsmanRuns: currentInnings.getOnStrikeBatsmanRuns(),
            offStrikeBatsmanRuns: currentInnings.getOffStrikeBatsmanRuns(),
            numberOfDeliveriesInOver: currentInnings.getNumberOfDeliveriesDoneInOver()
        )
    }
    
}
