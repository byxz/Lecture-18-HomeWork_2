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
    
    private let worker = NetWorker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advancedLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        worker.сancel()
    }
    
    func advancedLoad() {
        let myCompletionAfterLoading: (Data?, Error?) -> Void = { [weak self] data, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            guard let anyDict = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
            guard let dict = anyDict as? [String: String] else { return }
            
            let worldCupsData = WorldCupsData(dict: dict)
            DispatchQueue.main.async {
                self?.textView.text = "Date " + worldCupsData.dateString
            }
        }
        
        worker.loadData(completion: myCompletionAfterLoading)
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
}

