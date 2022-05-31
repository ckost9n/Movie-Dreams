//
//  MainTabBarController.swift
//  Movie Dreams
//
//  Created by Konstantin on 29.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    private func setupTabBar() {
        
        let mainVC = createNavController(vc: MainViewController(), itemName: "Home", itemImage: "house.fill")
        let movieCardVC = createNavController(vc: MovieCardController(), itemName: "Movie", itemImage: "play.circle")
        
        viewControllers = [mainVC, movieCardVC]
        tabBar.barTintColor = .darkBackgound
        tabBar.tintColor = .red
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(
            roundedRect: CGRect(
                x: 20,
                y: tabBar.bounds.minY - 5,
                width: tabBar.bounds.width - 40,
                height: tabBar.bounds.height + 10
            ), cornerRadius: (tabBar.frame.width / 2)).cgPath
        
        
        tabBar.layer.insertSublayer(layer, at: 0)
 
        
    }
    
    private func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(
            title: itemName,
            image: UIImage(systemName: itemImage),
            tag: 0
        )
//        item.imageInsets = UIEdgeInsets.init(top: 3, left: 0, bottom: 0, right: 0)
//        item.titlePositionAdjustment = .init(horizontal: 10, vertical: 10)
        
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        
        return navController
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
