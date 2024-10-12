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




