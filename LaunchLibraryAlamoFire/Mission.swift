//
//  Mission.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/18/18.
//  Copyright © 2018 petar. All rights reserved.
//

import Foundation

class Mission: Hashable, Equatable
{
    var hashValue: Int {
        return id!.hashValue
    }
    
    static func ==  (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(dictionary: [String:Any]?){
        guard let dictionary = dictionary else {return}
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        type = dictionary["type"] as? Int ?? 0
        wikiURL = dictionary["wikiURL"] as? String ?? ""
        typeName = dictionary["typeName"] as? String ?? ""
        let agenciesData = dictionary["agencies"] as? [[String:Any]]
        agencies = agenciesData?.compactMap{ agencyDict in return Agency(dictionary: agencyDict)}
    }
    
    var id:Int?
    var name:String?
    var description: String?
    var type: Int?
    var wikiURL: String?
    var typeName:String?
    var agencies:[Agency]?
}
