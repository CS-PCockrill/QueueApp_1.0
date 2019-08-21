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
        tabBar.tintColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
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
        let homeController = HomeViewController()
        let homeNavController = setupNavControllers(tabBarTitle: "Home", unselected: "home_unselected", selected: "home_selected", rootViewController: homeController)
        
//        let favoritesNavController = setupNavControllers(unselected: "like_unselected", selected: "like_selected", rootViewController: ChatController())
//
        let addItemController = UIViewController()
        let addNavController = setupNavControllers(tabBarTitle: "Sell", unselected: "plus_unselected", selected: "plus_unselected", rootViewController: addItemController)
        
        let offersNavController = setupNavControllers(tabBarTitle: "Offers", unselected: "grid", selected: "grid", rootViewController: OffersViewController())
//        let ordersController = OrdersViewController(collectionViewLayout: layout)
//        let ordersNavController = setupNavControllers(unselected: "like_unselected", selected: "like_selected", rootViewController: ordersController)
//
        
        let profileController = UserProfileController(collectionViewLayout: layout)
        let profileNavController = setupNavControllers(tabBarTitle: "Profile", unselected: "profile_unselected", selected: "profile_selected", rootViewController: profileController)
        
        //        tabBar.tintColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        tabBar.tintColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        tabBar.unselectedItemTintColor = UIColor.black
        tabBar.isTranslucent = false
        viewControllers = [homeNavController, offersNavController, addNavController, profileNavController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    fileprivate func setupNavControllers(tabBarTitle: String, unselected: String, selected: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: unselected)
        navController.tabBarItem.selectedImage = UIImage(named: selected)
        navController.tabBarItem.title = tabBarTitle
        
        return navController
    }
}
