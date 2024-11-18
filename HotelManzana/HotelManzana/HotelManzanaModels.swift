//
//  HotelManzanaModels.swift
//  HotelManzana
//
//  Created by Prince  on 18/11/24.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress : String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    
    var wifi: Bool
    var roomType: RoomType
    
    
}



struct RoomType: Equatable{
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var all: [RoomType]{
        return[
            RoomType(id: 0 , name: "Double", shortName: "2D", price: 179),
            RoomType(id: 1 , name: "Single", shortName: "1D", price: 209),
            RoomType(id: 2 , name: "Small", shortName: "s", price: 100),
            RoomType(id: 3 , name: "Double with Balcony", shortName: "2DB", price: 2000),
            
        ]
    }
     
    
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
        
    }
    
    
    
}

