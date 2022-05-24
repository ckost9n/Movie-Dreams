//
//  InfoViewController.swift
//  Movie Dreams
//
//  Created by Konstantin on 24.05.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        let color = #colorLiteral(red: 0.1764705882, green: 0.1568627451, blue: 0.2078431373, alpha: 1)
        navigationController?.navigationBar.setupNavigationBar(barColor: color, textColor: .white)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
