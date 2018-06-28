//
//  NasaObject.swift
//  url
//
//  Created by Mac on 24.06.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation

struct WorldCupsData1 {
    //let homeTeam: String
    //let group: String
    //let group: String?
    //let homeTeam: String?
    let tri: String?
    let flag: String?
    let full: String?
    
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) {
        tri = json["tri"] as? String ?? ""
        flag = json["flag"] as? String ?? ""
        full = json["full"] as? String ?? ""
        
  
    }
    
    /*
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.date(from: dateString)!
    }
 */
    
    
    
    /*
    
    init(dict: [String:Any]) {
        //homeTeam = dict["home_team"] as? String ?? ""
        //group = dict["group"] as? String ?? ""
        //visitantTeam = dict["visitant_team"] as? String ?? ""
        //dateString = dict["date"] as? String ?? ""
        tri = dict["tri"] as? String ?? ""
        flag = dict["flag"] as? String ?? ""
        full = dict["full"] as? String ?? ""
    }
 */
    
 
}
