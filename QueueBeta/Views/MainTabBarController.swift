//
//  MainTabBarController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
//import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 1 {
            //            let layout = UICollectionViewFlowLayout()
            let shareItemController = ItemDetailsController()
            //            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: shareItemController)
            present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupNavIcons()
    }
    
    func setupNavIcons() {
        let layout = UICollectionViewFlowLayout()
        let homeController = HomeViewController(collectionViewLayout: layout)
        let homeNavController = setupNavControllers(unselected: "home_unselected", selected: "home_selected", rootViewController: HomeViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
//        let favoritesNavController = setupNavControllers(unselected: "like_unselected", selected: "like_selected", rootViewController: ChatController())
//
        let addItemController = UIViewController()
        let addNavController = setupNavControllers(unselected: "plus_unselected", selected: "plus_unselected", rootViewController: addItemController)
        
//        let ordersController = OrdersViewController(collectionViewLayout: layout)
//        let ordersNavController = setupNavControllers(unselected: "like_unselected", selected: "like_selected", rootViewController: ordersController)
//
        
        let profileController = UserProfileController(collectionViewLayout: layout)
        let profileNavController = setupNavControllers(unselected: "profile_unselected", selected: "profile_selected", rootViewController: profileController)
        
        //        tabBar.tintColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        tabBar.tintColor = UIColor.black
        tabBar.unselectedItemTintColor = UIColor.black
        tabBar.isTranslucent = false
        viewControllers = [homeNavController, addNavController, profileNavController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func setupNavControllers(unselected: String, selected: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: unselected)
        navController.tabBarItem.selectedImage = UIImage(named: selected)
        
        return navController
    }
}
