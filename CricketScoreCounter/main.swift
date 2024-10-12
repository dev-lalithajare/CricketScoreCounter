//
//  main.swift
//  CricketScoreCounter
//
//  Created by Lalit Hajare on 20/09/24.
//

import Foundation

let scoreKeeper = ScoreKeeper()
let NUMBER_OF_OVERS = 2
let DELIVERIES_IN_OVER = 2
var numberOfDeliveriesDone = 0

while (numberOfDeliveriesDone < NUMBER_OF_OVERS * DELIVERIES_IN_OVER) {
    scoreKeeper.takeInputForDelivery()
    numberOfDeliveriesDone = scoreKeeper.getNumberOfDeliveriesForFirstInnings()
}

scoreKeeper.onInningsFinished()
numberOfDeliveriesDone = 0

while (numberOfDeliveriesDone < NUMBER_OF_OVERS * DELIVERIES_IN_OVER) {
    scoreKeeper.takeInputForDelivery()
    numberOfDeliveriesDone = scoreKeeper.getNumberOfDeliveriesForSecondInnings()
}

scoreKeeper.onMatchFinished()




