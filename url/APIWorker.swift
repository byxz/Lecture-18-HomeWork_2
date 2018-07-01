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
            guard let arr = jsonObject as? [[String:Any]] else {
                completion(nil, nil)
                print("Error deserializing JSON: \(String(describing: error))")
                return
            }

            
            struct Name {
                let flag: String
                let full: String
                let tri: String
            }
            
            struct HomeTeam {
                let name: Name
            }
            
            struct VisitantTeam {
                let name: Name
            }
            
            struct Location {
                let city: String
                let country: String
            }
            
            
            struct Game {
                let date: String
                let group: String
                let homeTeam: HomeTeam
                let location: Location
                let matchId: String
                let numMatch: String
                let stadium: String
                let startTime: String
                let time: String
                let timeZone: String
                let tournamentName: String
                let tournamentType: String
                let visitantTeam: VisitantTeam
                let year: String
            }

            var games = [Game]()
            
            for dict in arr {
                let date = dict["date"] as? String ?? ""
                let group = dict["group"] as? String ?? ""
                let matchId = dict["match_id"] as? String ?? ""
                let numMatch = dict["num_match"] as? String ?? ""
                let stadium = dict["stadium"] as? String ?? ""
                let startTime = dict["start_time"] as? String ?? ""
                let time = dict["time"] as? String ?? ""
                let timeZone = dict["time_zone"] as? String ?? ""
                let tournamentName = dict["tournament_name"] as? String ?? ""
                let tournamentType = dict["tournament_type"] as? String ?? ""
                let year = dict["year"] as? String ?? ""
                
                let homeTeam = dict["home_team"] as? [String: Any]
                let homeTeamName = homeTeam!["name"] as? [String: Any]
                let homeTeamNameFlag = homeTeamName!["flag"] as? String ?? ""
                let homeTeamNameFull = homeTeamName!["full"] as? String ?? ""
                let homeTeamNameTri = homeTeamName!["tri"] as? String ?? ""
                let homeTeamNameStruct = Name(flag: homeTeamNameFlag, full: homeTeamNameFull, tri: homeTeamNameTri)
                let homeTeamStruct = HomeTeam(name: homeTeamNameStruct)
                
                let visitantTeam = dict["visitant_team"] as? [String: Any]
                let visitantTeamName = visitantTeam!["name"] as? [String: Any]
                let visitantTeamNameFlag = visitantTeamName!["flag"] as? String ?? ""
                let visitantTeamNameFull = visitantTeamName!["full"] as? String ?? ""
                let visitantTeamNameTri = visitantTeamName!["tri"] as? String ?? ""
                let visitantTeamNameStruct = Name(flag: visitantTeamNameFlag, full: visitantTeamNameFull, tri: visitantTeamNameTri)
                let visitantTeamStruct = VisitantTeam(name: visitantTeamNameStruct)
                
                let location = dict["location"] as? [String: Any]
                let city = location!["city"] as? String ?? ""
                let country = location!["country"] as? String ?? ""
                let locationStruct = Location(city: city, country: country)
                
                
                
                let game = Game(date: date, group: group, homeTeam: homeTeamStruct, location: locationStruct, matchId: matchId, numMatch: numMatch, stadium: stadium, startTime: startTime, time: time, timeZone: timeZone, tournamentName: tournamentName, tournamentType: tournamentType, visitantTeam: visitantTeamStruct, year: year)
                games.append(game)
            }
            
            
            print(games)
            
            completion(nil, nil)
        }
        
        task.resume()
    }
    
    func сancel() {
        task?.cancel()
    }
}
