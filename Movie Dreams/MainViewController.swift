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
        $0.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    @objc func buttonTapped(_ sender: UIButton) {
        present(MovieCardController(), animated: true, completion: nil)
    }

    func initialize() {
        view.backgroundColor = .green
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    
}

