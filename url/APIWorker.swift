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
    }
    
    
    
    func loadData2(completion: @escaping ([WorldCupsData]?, Error?) -> Void) {
        
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

            guard
                let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                let dict = jsonObject as? [Any]
                else {
                    completion(nil, nil)
                    print("Error deserializing JSON: \(String(describing: error))")
                    return
            }
            
            for object in dict {

                print(object)

            }
            
            print(data)
            
            
            //let team = (first as AnyObject).compactMap { WorldCupsData(dict: $0) }
            //let team = homeTeam.compactMap { WorldCupsData(dict: $0) }
            //completion(team, nil)
        }
        
        task.resume()
    }
    
    
    
    func сancel() {
        task?.cancel()
    }
}
