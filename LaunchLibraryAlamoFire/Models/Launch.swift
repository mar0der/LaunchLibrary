//
//  Entity.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/18/18.
//  Copyright © 2018 petar. All rights reserved.
//

import Foundation

class Launch: Hashable, Equatable
{
    var hashValue: Int {
        return id!.hashValue
    }

    static func ==  (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(dictionary: [String:Any]?){
        guard let dictionary = dictionary else {return}
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        windowstart = dictionary["windowstart"] as? String ?? ""
        windowend = dictionary["windowend"] as? String ?? ""
        net = Date.llDate(dateString: dictionary["net"] as? String ?? "")
        wsstamp = dictionary["wsstamp"] as? String ?? ""
        westamp = dictionary["westamp"] as? String ?? ""
        netstamp = dictionary["netstamp"] as? String ?? ""
        isostart = dictionary["isostart"] as? String ?? ""
        isoend = dictionary["isoend"] as? String ?? ""
        isonet = dictionary["isonet"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        inhold = dictionary["inhold"] as? Int ?? 0
        tbdtime = dictionary["tbdtime"] as? Int ?? 0
        vidURLs = dictionary["vidURLs"] as? [String] ?? []
        vidURL = dictionary["vidURL"] as? String ?? ""
        infoURLs = dictionary["infoURLs"] as? [String] ?? []
        infoURL = dictionary["infoURL"] as? String ?? ""
        holdreason = dictionary["holdreason"] as? String ?? ""
        failreason = dictionary["failreason"] as? String ?? ""
        tbddate = dictionary["tbddate"] as? Int ?? 0
        probability = dictionary["probability"] as? Int ?? 0
        hashtag = dictionary["hashtag"] as? String ?? ""
        changed = dictionary["changed"] as? String ?? ""
        let locationData = dictionary["location"] as? [String:Any]
        location = Location(dictionary: locationData)
        let rocketData = dictionary["rocket"] as? [String:Any]
        rocket = Rocket(dictionary: rocketData)
        let missionsData = dictionary["missions"] as? [[String:Any]]
        missions = missionsData?.compactMap{missionDict in return Mission(dictionary: missionDict)}
        let lspData = dictionary["lsp"] as? [String:Any]
        lsp = Lsp(dictionary: lspData)
    }
    
    var id:Int?
    var name:String?
    var windowstart: String?
    var windowend: String?
    var net: Date?
    var wsstamp: String?
    var westamp: String?
    var netstamp: String?
    var isostart: String?
    var isoend: String?
    var isonet: String?
    var status:Int?
    var inhold:Int?
    var tbdtime:Int?
    var vidURLs:[String]?
    var vidURL:String?
    var hashtag:String?
    var infoURLs:[String]?
    var infoURL: String?
    var holdreason: String?
    var failreason: String?
    var tbddate: Int?
    var probability: Int?
    var changed: String?
    var location: Location?
    var rocket: Rocket?
    var missions: [Mission]?
    var lsp: Lsp?
}
