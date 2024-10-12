//
//  Delivery.swift
//  CricketScoreCounter
//
//  Created by Lalit Hajare on 21/09/24.
//

import Foundation

enum BallType{
    case NO
    case WIDE
    case VALID    
    case OUT
}

struct Delivery{
    let id = UUID().uuidString
    let ballType: BallType
    let runsScored: Int
    let batsmanId: String
    let bowlerId: String
    let isFirstDeliveryInOver: Bool
}
