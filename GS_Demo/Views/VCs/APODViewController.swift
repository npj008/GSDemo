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
        
        ImageManager.shared.downloadImage(with: "https://apod.nasa.gov/apod/image/2207/JupiterRing_WebbSchmidt_2429.jpg", completionHandler: { img, success in
            print(img)
        }, placeholderImage: nil)
    }
}
