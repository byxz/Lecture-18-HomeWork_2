//
//  NasaObject.swift
//  url
//
//  Created by Mac on 24.06.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation

struct WorldCupsData {
    //let homeTeam: String
    //let group: String
    let tri: String?
    //let flag: String?
    //let full: String?
    /*
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.date(from: dateString)!
    }
 */
    
    
    init(dict: [String: Any]) {
        //homeTeam = dict["home_team"] as? String ?? ""
        //group = dict["group"] as? String ?? ""
        //visitantTeam = dict["visitant_team"] as? String ?? ""
        //dateString = dict["date"] as? String ?? ""
        tri = dict["tri"] as? String ?? ""
    }
 
}
