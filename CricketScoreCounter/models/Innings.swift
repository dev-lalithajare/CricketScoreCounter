//
//  Innings.swift
//  CricketScoreCounter
//
//  Created by Lalit Hajare on 08/10/24.
//

import Foundation

class Innings{
    
    var inningNumber: Int = 1
    var target: Int = 0
    var deliveries: [Delivery] = []
    var currentBattingTeam: Team? = nil
    var currentBowlingTeam: Team? = nil
    var oversCounter: Int = 0
    
    func checkOverCounter() -> Bool{
//        if(getNumberOfDeliveriesDoneInOver() == 0){
//            return false
//        }
        let validDeliveries = deliveries.filter{ $0.ballType == BallType.VALID || $0.ballType == BallType.OUT }.count
        if (validDeliveries % 6 == 0) {
            oversCounter += 1
            return true
        }
        return false
    }
    
    init(inningNumber: Int){
        self.inningNumber = inningNumber
    }
    
    func onBatsmanOut(){
        var playerIdThatisOut: String = ""
        var playerIdisNextBatsman: String = ""
        for (id, status) in currentBattingTeam!.battingSequence {
            if(status == PlayerBattingStatus.ON_STRIKE){
                playerIdThatisOut = id
            }
            if(status == PlayerBattingStatus.PENDING){
                playerIdisNextBatsman = id
            }
        }
        currentBattingTeam?.battingSequence[playerIdThatisOut] = PlayerBattingStatus.OUT
        currentBattingTeam?.battingSequence[playerIdisNextBatsman] = PlayerBattingStatus.ON_STRIKE
    }
    
    func setTeams(teamA: Team, teamB: Team){
        currentBattingTeam = teamA
        currentBowlingTeam = teamB
    }
    
    func getTotalScore() -> Int{
        return deliveries.map({$0.runsScored}).reduce(0,+)
    }
    
    func getNumberOfDeliveries() -> Int{
        return deliveries.filter{ $0.ballType == BallType.VALID || $0.ballType == BallType.OUT }.count
    }
    
    func getRunsByBatsmanId(batsmanId: String) -> Int{
        return deliveries.filter{ $0.batsmanId == batsmanId }.map({$0.runsScored}).reduce(0,+)
    }
    
    func getOffStrikeBatsmanRuns() -> Int{
        let batsmanId = currentBattingTeam?.battingSequence.first{ $0.value == PlayerBattingStatus.OFF_STRIKE }?.key
        return deliveries.filter{ $0.batsmanId == batsmanId }.map({$0.runsScored}).reduce(0,+)
    }
    
    func getOffStrikeBatsmanName() -> String{
        let batsmanId = currentBattingTeam?.battingSequence.first{ $0.value == PlayerBattingStatus.OFF_STRIKE }?.key
        return (currentBattingTeam?.players.first{ $0.id == batsmanId }?.name)!
    }
    
    func getOnStrikeBatsmanRuns() -> Int{
        let batsmanId = currentBattingTeam?.battingSequence.first{ $0.value == PlayerBattingStatus.ON_STRIKE }?.key
        return deliveries.filter{ $0.batsmanId == batsmanId }.map({$0.runsScored}).reduce(0,+)
    }
    
    func getOnStrikeBatsmanName() -> String{
        let batsmanId = currentBattingTeam?.battingSequence.first{ $0.value == PlayerBattingStatus.ON_STRIKE }?.key
        return (currentBattingTeam?.players.first{ $0.id == batsmanId }?.name)!
    }
    
    func getBowlerName() -> String{
        let bowlerId = currentBowlingTeam?.bowlingSequence.first{ $0.value == PlayerBowlingStatus.BOWLING }?.key
        return (currentBowlingTeam?.players.first{ $0.id == bowlerId }?.name)!
    }
    
    func hasAnyValidDelivery() -> Bool{
        return (deliveries.first{ $0.ballType == BallType.VALID || $0.ballType == BallType.OUT } != nil)
    }
    
    private func getDeliveriesInCurrentOver() -> [Delivery]{
        if(deliveries.first { $0.isFirstDeliveryInOver } == nil){
            return []
        }
        let from = deliveries.lastIndex(where: { $0.isFirstDeliveryInOver }) ?? 0
        let to = deliveries.count - 1
        let validDeliveries = deliveries[from...to]
        return Array(validDeliveries.filter{ $0.ballType == BallType.VALID || $0.ballType == BallType.OUT })
    }
    
    func getNumberOfDeliveriesDoneInOver() -> Int{
        return getDeliveriesInCurrentOver().count
    }
    
    func getRunsInOver() -> Int{
        let deliveriesInOver = getDeliveriesInCurrentOver()
        if(deliveriesInOver.isEmpty){
            return getTotalScore()
        }
        return deliveriesInOver.map({$0.runsScored}).reduce(0,+)
    }
    
    func getTotalSixes() -> Int{
        return deliveries.filter{ $0.runsScored == 6 }.count
    }
    
    func getTotalFours() -> Int{
        return deliveries.filter{ $0.runsScored == 4 }.count
    }
    
    func getFoursByBatsman(batsmanId: String) -> Int{
        return deliveries.filter{ $0.runsScored == 4 && $0.batsmanId == batsmanId }.count
    }
    
    func getSixesByBatsman(batsmanId: String) -> Int{
        return deliveries.filter{ $0.runsScored == 6 && $0.batsmanId == batsmanId }.count
    }
    
    func getOversByBowler(bowlerId: String) -> Int{
        return deliveries.filter{ $0.bowlerId == bowlerId && $0.isFirstDeliveryInOver }.count
    }
    
    func getTotalWickets() -> Int{
        return deliveries.filter{ $0.ballType == BallType.OUT }.count
    }
    
    func getTotalNumberOfOversFinished() -> Int{
        return deliveries.filter{ $0.isFirstDeliveryInOver }.count
    }
    
    func prepareBatsmanData() -> [Batsman]{
        var batsmen: [Batsman] = []
        for (id, _) in currentBattingTeam!.battingSequence {
            let player = currentBattingTeam!.players.first{ $0.id == id }
            let runs = getRunsByBatsmanId(batsmanId: id)
            let sixes = getSixesByBatsman(batsmanId: id)
            let fours = getFoursByBatsman(batsmanId: id)
            batsmen.append(
                Batsman(
                    playerId: id,
                    name: player!.name,
                    runs: runs,
                    sixes: sixes,
                    fours: fours
                )
            )
        }
        return batsmen
    }
    
    func getWicketsByBowler(bowlerId: String) -> Int{
        return deliveries.filter{ $0.bowlerId == bowlerId && $0.ballType == BallType.OUT }.count
    }
    
    func getWidesByBowler(bowlerId: String) -> Int{
        return deliveries.filter{ $0.bowlerId == bowlerId && $0.ballType == BallType.WIDE }.count
    }
    
    func getTotalWides() -> Int{
        return deliveries.filter{ $0.ballType == BallType.WIDE }.count
    }
    
    func getNosByBowler(bowlerId: String) -> Int{
        return deliveries.filter{ $0.bowlerId == bowlerId && $0.ballType == BallType.WIDE }.count
    }
    
    func getTotalNos() -> Int{
        return deliveries.filter{ $0.ballType == BallType.WIDE }.count
    }

    
    func prepareBowlerData() -> [Bowler]{
        var bowlers: [Bowler] = []
        for (id, _) in currentBowlingTeam!.bowlingSequence {
            let player = currentBowlingTeam!.players.first{ $0.id == id }
            let overs = getOversByBowler(bowlerId: id)
            let wickets = getWicketsByBowler(bowlerId: id)
            let wides = getWidesByBowler(bowlerId: id)
            let nos = getNosByBowler(bowlerId: id)
            bowlers.append(
                Bowler(
                    bowlerId: id,
                    name: player!.name,
                    overs: overs,
                    wides: wides,
                    nos: nos,
                    wickets: wickets
                )
            )
        }
        return bowlers
    }
}
