//
//  MainTabBarController.swift
//  TextFields
//
//  Created by Olya Sabadina on 2022-12-31.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        
        viewControllers = [
            generateVC(viewController: NoDigitsViewController(),
                       title: "NO digits" ,
                       image: UIImage(systemName: "abs.circle.fill")),
            
            generateVC(viewController: IndicationLimitViewController(),
                       title: "Input character",
                       image: UIImage(systemName: "10.circle.fill")),
            
            generateVC(viewController: MaskWDViewController(),
                       title: "Mask w-d",
                       image: UIImage(systemName: "l1.rectangle.roundedbottom.fill")),
            
            generateVC(viewController: LinkViewController(),
                       title: "Link",
                       image: UIImage(systemName: "link.circle.fill")),
            
            generateVC(viewController: PasswordViewController(),
                       title: "Password",
                       image: UIImage(systemName: "lock.circle.fill"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
        
    }
}







