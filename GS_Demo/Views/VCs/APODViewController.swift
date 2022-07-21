//
//  APODViewController.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import UIKit

class APODViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        APIService.shared.fetchAPODDetails(date: "") { resul in
            switch resul {
            case .success(let data):
                print(data)
            case .failure(let err):
                print(err)
            }
        }
    }
}
