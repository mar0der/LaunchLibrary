//
//  Pad.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/18/18.
//  Copyright © 2018 petar. All rights reserved.
//

import Foundation

class Pad: Hashable, Equatable
{
    var hashValue: Int {
        return id!.hashValue
    }
    
    static func ==  (lhs: Pad, rhs: Pad) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(dictionary: [String:Any]?){
        guard let dictionary = dictionary else {return}
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        infoURL = dictionary["infoURL"] as? String ?? ""
        wikiURL = dictionary["wikiURL"] as? String ?? ""
        mapURL = dictionary["mapURL"] as? String ?? ""
        
        latitude = dictionary["latitude"] as? Double ?? 0.00
        longitude = dictionary["longitude"] as? Double ?? 0.00
    }
    
    var id:Int?
    var name:String?
    var infoURL: String?
    var wikiURL: String?
    var mapURL: String?
    var latitude: Double?
    var longitude: Double?
}
