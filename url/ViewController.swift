//
//  ViewController.swift
//  url
//
//  Created by Mac on 21.06.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    private let worker = APIWorker()
    
    
    //Как павильно получить массив и с ним адальше работать?
    var array:[Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advancedLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        worker.сancel()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    private func showAlert(with error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        
        show(alertController, sender: nil)
    }
    
    
    private func advancedLoad() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        worker.loadData { (games, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(with: error)
                }
                return
            }
            
            guard let games = games else { return }
            
            DispatchQueue.main.async {
                
                self.textView.text = "\(games)"
                self.array = games
            }
        }
        
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //Заменить на число элементов в массиве
        return 48
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomeCell
        
        //first засенить на IndexPath массива
        
        cell.triOfHomeTeamLabel.text = array.first?.homeTeam.name.tri
        cell.fullOfHomeTeamLabel.text = array.first?.homeTeam.name.full
        
        cell.triOfVisitTeamLabel.text = array.first?.visitantTeam.name.tri
        cell.fullOfVisitTeamLabel.text = array.first?.visitantTeam.name.full
        
        return cell
    }
    
    
}

