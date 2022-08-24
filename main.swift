//
//  main.swift
//  FligthSeatBookingSystem
//
//  Created by user on 18/08/2022.
//

import Foundation


var server = SeatBooking()

var queue = DispatchQueue.global()


for i in 0 ... 24 {
    queue.async {
        server.bookSeat("\(i)", .economic, Int.random(in: 41 ..< 100))
    }
}
for i in 25 ... 50 {
    queue.async {
        server.bookSeat("\(i)", .firstClass, Int.random(in: 0 ..< 100))
    }
}
sleep(10)
print("-------------------------------------------------------")
for i in 0 ..< 100 {
    if let passenger = server.reservedSeats[i] {
        queue.async {
            server.changeSeat(passenger, Int.random(in: 0 ..< 100))
        }
    }
}

sleep(10)
