//
//  NetWorker.swift
//  url
//
//  Created by Mac on 24.06.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation

class NetWorker {
    var task: URLSessionDataTask?
    
    @discardableResult
    func loadData(completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        let url = Global.url
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("LsHoEdcE1pmshD6kwQzdL2S4CpN0p1yJltgjsnA9fyaRGXs3Fj", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let responseBlock: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            self.task = nil
            completion(data, error)
        }
        
        task = URLSession.shared.dataTask(with: request, completionHandler: responseBlock)
        task?.resume()
        return task!
    }
    
    func сancel() {
        task?.cancel()
    }
}
