//
//  Location.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/18/18.
//  Copyright © 2018 petar. All rights reserved.
//

import Foundation
class Location: Hashable, Equatable
{
    var hashValue: Int {
        return id!.hashValue
    }
    
    static func ==  (lhs: Location, rhs: Location) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(dictionary: [String:Any]?){
        guard let dictionary = dictionary else {return}
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        infoURL = dictionary["infoURL"] as? String ?? ""
        wikiURL = dictionary["wikiURL"] as? String ?? ""
        countryCode = dictionary["countryCode"] as? String ?? ""
        let padsData = dictionary["pads"] as? [[String:Any]]
        pads = padsData?.compactMap { padDict in return Pad(dictionary: padDict) }
    }
    
    var id:Int?
    var name:String?
    var infoURL: String?
    var wikiURL: String?
    var countryCode: String?
    var pads:[Pad]?
}
