//
//  main.swift
//  FligthSeatBookingSystem
//
//  Created by user on 18/08/2022.
//

import Foundation

var flight = Flight()

var queue = DispatchQueue.global()
var firstClassQueue = DispatchQueue.global(qos: .default)
var econimicQueue = DispatchQueue.global(qos: .utility)
for i in 0 ... 24 {
    queue.sync {
        flight.bookSeat("\(i)", "Economic", Int.random(in: 41 ..< 100))
    }
}
for i in 25 ... 50 {
    queue.sync {
        flight.bookSeat("\(i)", "First class", Int.random(in: 0 ..< 100))
    }
}

for _ in 0 ... 10 {
    let passenger = flight.passengers.randomElement()!
    if passenger.seatType == "First class" {
        firstClassQueue.sync {
            print("First class: higher priority")
            flight.changeSeat(passenger, Int.random(in: 0 ..< 100))
        }
    } else {
        econimicQueue.sync {
            print("Economic: lower priority")
            flight.changeSeat(passenger, Int.random(in: 0 ..< 100))
        }
    }
    
}
