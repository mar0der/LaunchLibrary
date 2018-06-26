//
//  WebAPI.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/18/18.
//  Copyright © 2018 petar. All rights reserved.
//

import Foundation
import Alamofire

class WebAPI
{
    static let baseUrl = "https://launchlibrary.net/1.4/"
    
    static func getLaunches(type: LaunchType, limit: Int, offset:Int, sort: SortEnum, completion: @escaping ([Launch]?) -> Void){
        switch type {
        case .feature:
            let urlString = self.baseUrl + "launch/?offset=\(offset)&next=\(limit)"
            self.getLaunches(urlString: urlString, completion: completion)
        case .history:
            //FIXME: use the current date
            let urlString = self.baseUrl + "launch/1930-01-01/2018-06-27/?limit=\(limit)&offset=\(offset)&sort=\(sort.rawValue)"
            self.getLaunches(urlString: urlString, completion: completion)
        }
    }
    
    private static func getLaunches(urlString: String, completion: @escaping ([Launch]?) -> Void) {
    
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        Alamofire.request(url, method: .get, parameters: ["include_docs": "true"])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error?.localizedDescription))")
                        completion(nil)
                    return
                }
                guard let value = response.result.value as? [String:Any],
                let launchesData = value["launches"] as? [[String:Any]] else {
                        print("Bad data received from launc library service")
                        completion(nil)
                        return
                }
                let launches = launchesData.map { launchDict in return Launch(dictionary: launchDict) }
                completion(launches)
        }
    }
}
