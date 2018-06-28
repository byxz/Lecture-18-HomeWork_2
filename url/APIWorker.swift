//
//  NetWorker.swift
//  url
//
//  Created by Mac on 24.06.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation

class APIWorker {
    
    var task: URLSessionDataTask?
    
    enum URLs {
        static let mainUrl = "https://stroccoli-sebasfreetest-v1.p.mashape.com/calendar"
    }
    
    enum Keys {
        static let serviceKey = "LsHoEdcE1pmshD6kwQzdL2S4CpN0p1yJltgjsnA9fyaRGXs3Fj"
        static let serviceKeyTwo = "1rksEaJHXjmshr9Os90W2v0joaavp1P1XHXjsn9EjaGpGlgcaM"
        
    }
    
    
    
    func loadData(completion: @escaping ([WorldCupsData1]?, Error?) -> Void) {
        
        //Необходимо сделать проверку
        let url = URL(string: URLs.mainUrl)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue(Keys.serviceKey, forHTTPHeaderField: "X-Mashape-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            //  Стопор полнейший не пойму как json раскрывать правлиьно guardom
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
            print("========1")
            //print(jsonObject)
            print("========1")
            guard let dict = jsonObject as? [[String:Any]] else { return }
            print("========2")
            print(dict)
            print("========2")
            guard let type = dict["tournament_type"] as? [String:Any] else { return }
            for dataPoint in dict {
                if let weatherObject = try? WorldCupsData1(json: dataPoint) {
                    print(weatherObject)
                }
            }
            
         
            
            //guard let homeTeamDict = dict["String: Any"] as? [String: Any] else {
        
                ////completion(nil, nil)
                //print("Error deserializing JSON: \(String(describing: error))")
                //return
            
            //print("========3")
            //print(homeTeamDict)
            //print("========3")
            //let homeTeam = jsonObject!["home_team"] as? [String: Any],
            //let name = homeTeam["name"] as? [[String: Any]]
            //let dict = jsonObject as? [Any]
            
            
        
           // let triStrings = homeTeamDict.compactMap { WorldCupsData1(json: $0)}
            //completion(triStrings, nil)
            
        }
        //print(homeTeam)
        
        //let nameTeam = name.compactMap { WorldCupsData1(json: $0 ) }
        
        //print(nameTeam)
        //completion(nameTeam, nil)
        
        //let team = (first as AnyObject).compactMap { WorldCupsData(dict: $0) }
        //let team = homeTeam.compactMap { WorldCupsData(dict: $0) }
        //completion(team, nil)
        
        
        task.resume()
    }
    
    
    
    func сancel() {
        task?.cancel()
    }
}
