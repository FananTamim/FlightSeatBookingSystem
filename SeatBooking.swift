//
//  SeatBooking.swift
//  FligthSeatBookingSystem
//
//  Created by user on 24/08/2022.
//

import Foundation

struct SeatBooking{

    var flight = Flight()
    var reservedSeats = [Int: Passenger]()
    private let lock = NSLock()
    
    mutating func bookSeat(_ name: String, _ type: passengerType, _ seatNumber: Int){
        
        guard type == .firstClass || type == .economic else{
            print("Wrong seat type")
            return
        }
        guard seatNumber >= 0 && seatNumber < 100 else{
            print("Seat number is out of range")
            return
        }
        guard flight.checkSeatType(type, seatNumber) else {
            print("Seat type and number doesn't match")
            return
        }
        lock.lock()
        defer {lock.unlock()}
        guard !flight.checkSeatIfEmpty(seatNumber) else {
            print("This seat is reserved")
            return
        }
        let newPassenger = Passenger(name: name, type: type)
        flight.reserveSeat(seatNumber)
        reservedSeats[seatNumber] = newPassenger
        print("Passenger \(name) reserves seat NO.\(seatNumber)")
    }
    
    mutating func changeSeat(_ passenger: Passenger, _ newSeat: Int){
        guard Date().timeIntervalSince(passenger.bookingTime) < 86400 else {
            print("Can't change becausce passenger reserved before more than 24 hours ")
            return
        }
        guard flight.checkSeatType(passenger.type, newSeat) else {
            print("Seat type and number doesn't match")
            return
        }
        var prioirtyQueue = PrioirtyQueue()
        lock.lock()
        prioirtyQueue.add(passenger)
        lock.unlock()
        lock.lock()
        defer {lock.unlock()}
        if !flight.checkSeatIfEmpty(newSeat) {
            if let currentPassenger = prioirtyQueue.remove() {
                let oldSeat = reservedSeats.someKey(forValue: currentPassenger)
                    reservedSeats[oldSeat!] = nil
                    reservedSeats[newSeat] = currentPassenger
                print("Passenger \(currentPassenger.name) (type: \(currentPassenger.type)) changes to seat NO.\(newSeat)")
            }
        } else {
            print("Can't change to seat NO.\(newSeat), it is reserved")
        }
    }
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}

struct PrioirtyQueue {
    var prioirtyQueue = Array<Passenger>()
    
    func isEmpty() -> Bool {
        return prioirtyQueue.isEmpty
    }
    mutating func add(_ passenger: Passenger){
        if passenger.type == .firstClass {
            prioirtyQueue.insert(passenger, at: 0)
        } else{
            prioirtyQueue.append(passenger)
        }
    }
    mutating func remove() -> Passenger? {
        return prioirtyQueue.isEmpty ? nil : prioirtyQueue.remove(at: 0)
    }
    
}
