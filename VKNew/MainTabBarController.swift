//
//  MainTabBarController.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let itemMain = MainViewController()
        let itemProfile = ProfileViewController()
        let itemSaved = SavedPostViewController()
    
        itemMain.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        itemProfile.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle"))
        itemSaved.tabBarItem = UITabBarItem(title: "Сохраненные", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart"))
        
        let controllers = [itemMain, itemProfile, itemSaved]
        self.viewControllers = controllers
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}
