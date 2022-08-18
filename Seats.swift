//
//  Seats.swift
//  FligthSeatBookingSystem
//
//  Created by user on 18/08/2022.
//

import Foundation

class Flight {
    static var seats = [Bool]()
    var passengers = Set<Passenger>()
    private let lock = NSLock()
    init() {
        Flight.seats = [Bool](repeating: false, count: 100)
        passengers = []
    }
    
    func test() {
        print(Flight.seats)
    }
    func checkSeatIfEmpty(_ seatNumber: Int) -> Bool {
        Flight.seats[seatNumber]
    }
    func reserveSeat(_ seatNumber: Int) {
        Flight.seats[seatNumber] = true
    }
    func bookSeat(_ name: String, _ seatType: String, _ seatNumber: Int){
        
        guard seatType == "First class" || seatType == "Economic" else{
            print("Wrong seat type")
            return
        }
        guard seatNumber >= 0 && seatNumber < 100 else{
            print("Seat number is out of range")
            return
        }
        guard checkSeatType(seatType, seatNumber) else {
            print("Seat type and number doesn't match")
            return
        }
        lock.lock()
        defer {lock.unlock()}
        guard !checkSeatIfEmpty(seatNumber) else {
            print("This seat is reserved")
            return
        }
        passengers.insert(Passenger(name: name, seatType: seatType, seatNumber: seatNumber))
        reserveSeat(seatNumber)
        print("Passenger \(name) reserves seat NO.\(seatNumber)")
        
    }
    func checkSeatType(_ type: String, _ number: Int) -> Bool{
        if type == "Economic" && number < 41 {
            return false
        } else{
            return true
        }
    }
    func changeSeat(_ passenger: Passenger, _ newSeat: Int){
        guard Date().timeIntervalSince(passenger.bookingTime) < 86400 else {
            print("Can't change becausce passenger reserved before more than 24 hours")
            return
        }
        guard checkSeatType(passenger.seatType, newSeat) else {
            print("Seat type and number doesn't match")
            return
        }
        lock.lock()
        defer {lock.unlock()}
        if !checkSeatIfEmpty(newSeat) {
            passenger.seatNumber = newSeat
            print("Passenger \(passenger.name) changes to seat NO.\(newSeat)")
        } else {
            print("Can't change to seat NO.\(newSeat), it is reserved")
        }
    }
    
}
