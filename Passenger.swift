//
//  Passenger.swift
//  FligthSeatBookingSystem
//
//  Created by user on 18/08/2022.
//

import Foundation

class Passenger: Hashable {
    func hash(into hasher: inout Hasher) {
           hasher.combine(ObjectIdentifier(self))
       }
    static func == (lhs: Passenger, rhs: Passenger) -> Bool {
        lhs.seatNumber == rhs.seatNumber
    }
    
    let name: String
    var seatNumber : Int
    let bookingTime : Date
    var seatType: String
    
    init(name: String, seatType: String, seatNumber: Int) {
        self.name = name
        self.seatType = seatType
        self.seatNumber = seatNumber
        self.bookingTime = Date()
    }
}

