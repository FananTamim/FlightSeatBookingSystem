//
//  Seats.swift
//  FligthSeatBookingSystem
//
//  Created by user on 18/08/2022.
//

import Foundation

struct Flight {
    
    private var seats = [Bool]()
    
    init() {
        seats = [Bool](repeating: false, count: 100)
    }
    func checkSeatIfEmpty(_ seatNumber: Int) -> Bool {
        seats[seatNumber]
    }
    mutating func reserveSeat(_ seatNumber: Int) {
        seats[seatNumber] = true
    }
    func checkSeatType(_ type: passengerType, _ number: Int) -> Bool{
        if type == .economic && number < 41 {
            return false
        } else{
            return true
        }
    }    
}
