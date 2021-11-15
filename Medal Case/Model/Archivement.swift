//
//  Archivement.swift
//  Medal Case
//
//  Created by Fang Sun on 2021-11-09.
//

import Foundation

struct PersonalRecord: Codable{
    var image:String
    var name:String
    var time:String
    var height:String
    var isCompleted: Bool
    
    enum CodingKeys: String, CodingKey{
        case image = "image"
        case name = "name"
        case time = "time"
        case height = "height"
        case isCompleted = "iscompleted"
    }
}

struct VirtualRace: Codable{
    var image:String
    var name:String
    var time:String
    var height:String
    var isCompleted: Bool
    
    enum CodingKeys: String, CodingKey{
        case image = "image"
        case name = "name"
        case time = "time"
        case height = "height"
        case isCompleted = "iscompleted"
    }
}

struct PersonalRecords:Codable {
    var items:[PersonalRecord]
    
    enum CodingKeys: String, CodingKey{
        case items = "personalrecords"
    }
}

struct VirtualRaces:Codable {
    var items:[VirtualRace]
    
    enum CodingKeys: String, CodingKey{
        case items = "virtualraces"
    }
}
