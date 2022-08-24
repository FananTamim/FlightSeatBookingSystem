//
//  Passenger.swift
//  FligthSeatBookingSystem
//
//  Created by user on 18/08/2022.
//

import Foundation

struct Passenger: Equatable {
    
    let name: String
    let bookingTime : Date
    let type: passengerType
    
    init(name: String, type: passengerType) {
        self.name = name
        self.type = type
        self.bookingTime = Date()
    }
}

enum passengerType {
    case firstClass
    case economic
}

