//
//  MainViewController.swift
//  Movie Dreams
//
//  Created by Konstantin on 24.05.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    let button: UIButton = {
        $0.setTitle("Button", for: .normal)
        return $0
    }(UIButton())

    func initialize() {
        view.backgroundColor = .green
    }

}

