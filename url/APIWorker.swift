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
    
    
    
    func loadData(completion: @escaping ([WorldCupsData]?, Error?) -> Void) {
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
            
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
            guard let dict = jsonObject as? [[String:Any]] else {
                completion(nil, nil)
                print("Error deserializing JSON: \(String(describing: error))")
                return
            }
            
            //Хороший метод
            var arrayTest: [String: Any] = [:]
            for i in dict {
                arrayTest = i
            }
            print(arrayTest.count)
            print(dict.count)
            
            
            let event = dict[0]
            
            //Просто тест
            let stadium = event["stadium"]
            print(stadium ?? "ERROR stadium!")
            let time = event["time"]
            print(time ?? "ERROR time!")
            let year = event["year"]
            print(year ?? "ERROR year!")
            
            //Что-то костыльно очень.
            let a = WorldCupsData(json: event)
            let b = [a]
            print(a ?? "xz")
            completion(b as? [WorldCupsData], nil)
        }
        
        task.resume()
    }
    
    func сancel() {
        task?.cancel()
    }
}
