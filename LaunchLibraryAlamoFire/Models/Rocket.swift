//
//  Rocket.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/18/18.
//  Copyright © 2018 petar. All rights reserved.
//

import Foundation
class Rocket: Hashable, Equatable
{
    var hashValue: Int {
        return id!.hashValue
    }
    
    static func ==  (lhs: Rocket, rhs: Rocket) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(dictionary: [String:Any]?){
        guard let dictionary = dictionary else {return}
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        configuration = dictionary["configuration"] as? String ?? ""
        familyname = dictionary["familyname"] as? String ?? ""
        let agenciesData = dictionary["agencies"] as? [[String:Any]]
        agencies = agenciesData?.compactMap{agencyDict in return Agency(dictionary: agencyDict) }
        wikiURL = dictionary["wikiURL"] as? String ?? ""
        infoURLs = dictionary["infoURLs"] as? [String] ?? []
        imageURL = dictionary["imageURL"] as? String ?? ""
        imageSizes = dictionary["imageSizes"] as? [Int] ?? []
    }
    
    var id:Int?
    var name:String?
    var configuration: String?
    var familyname: String?
    var agencies: [Agency]?
    var wikiURL: String?
    var infoURLs:[String]?
    var imageURL: String?
    var imageSizes: [Int]?
}
