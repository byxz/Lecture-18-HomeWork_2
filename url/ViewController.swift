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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advancedLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        worker.сancel()
    }
    
    private func showAlert(with error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        
        show(alertController, sender: nil)
    }
    
    
    private func advancedLoad() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        worker.loadData2 { (WorkCupsData, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(with: error)
                }
                return
            }
            
            guard let WorkCupsData = WorkCupsData else { return }
            
            print(WorkCupsData.count)
            
            DispatchQueue.main.async {
                self.textView.text = "Flag \(WorkCupsData.count)"
            }
        }
    }


    /*
    func advancedLoad() {
        let myCompletionAfterLoading: ([WorldCupsData]?, Error?) -> Void = { [weak self] data, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            guard let anyDict = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
    
            //let anyDict = try? JSONDecoder().decode([WorldCupsData].self, from: data)
            print ("any", anyDict)
            if anyDict is [String : Any] {
                print("It's a dict")
            }
            let dict = anyDict as? [String : Any]
            let worldCupsData = WorldCupsData(dict: dict!)
            
            
        
            //let worldCupsData = WorldCupsData(dict: dict)
            DispatchQueue.main.async {
                self?.textView.text = "Flag " + (worldCupsData.tri)!
            }
        }
        
        worker.loadData2(completion: myCompletionAfterLoading)
    }
 
 
    
    func primitiveApproach() {
        let url = Global.url
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let str = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    self.textView.text = str
                }
            }
            catch {
                print(error)
            }
        }
    }
 */
}

