//
//  Agency.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/18/18.
//  Copyright © 2018 petar. All rights reserved.
//

import Foundation

class Agency: Hashable, Equatable
{
    var hashValue: Int {
        return id!.hashValue
    }
    
    static func ==  (lhs: Agency, rhs: Agency) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(dictionary: [String:Any]?){
        guard let dictionary = dictionary else {return}
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        abbrev = dictionary["abbrev"] as? String ?? ""
        countryCode = dictionary["countryCode"] as? String ?? ""
        type = dictionary["type"] as? Int ?? 0
        infoURL = dictionary["infoURL"] as? String ?? ""
        wikiURL = dictionary["wikiURL"] as? String ?? ""
        changed = dictionary["changed"] as? String ?? ""
        infoURLs = dictionary["infoURLs"] as? [String] ?? []
        imageSizes = dictionary["imageSizes"] as? [Int] ?? []
        imageURL = dictionary["imageURL"] as? String ?? ""
    }
    
    var id:Int?
    var name:String?
    var abbrev: String?
    var countryCode: String?
    var type: Int?
    var infoURL:String?
    var wikiURL:String?
    var changed:String?
    var infoURLs: [String]?
    var imageSizes: [Int]?
    var imageURL: String?
}
