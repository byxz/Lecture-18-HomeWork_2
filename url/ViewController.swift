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
        worker.loadData { (WorkCupsData, error) in
    
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(with: error)
                }
                return
            }
            
            guard let workCupsData = WorkCupsData else { return }
            
            print(workCupsData.count)
           
            for _ in workCupsData {
                print("hello")
            }
            
            DispatchQueue.main.async {
                self.textView.text = "\(workCupsData)"
            }
        }
    }

}

