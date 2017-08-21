//
//  VEXTabBarController.swift
//  V2EX
//
//  Created by Kyle on 21/8/17.
//  Copyright © 2017年 com.Kyle. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabBarController: ESTabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        var viewControllers = [UINavigationController]()
        let itemsData: Array<(String, String, String, UIViewController)> = [
            ("Home", "home", "home_1", HomeViewController()),
            ("Find", "find", "find_1", DiscoveryViewController()),
            ("More", "favor", "favor_1", Publish_ViewController()),
            ("Message", "message", "message_1", MessageViewController()),
            ("Me", "me", "me_1", MineViewController())
        ]
        
        for (title, norName, selectName, viewController) in itemsData {
            
            viewController.title = title
            let subTabBarItem = ESTabBarItemContentView() 
            subTabBarItem.textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
            subTabBarItem.highlightTextColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
            subTabBarItem.iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
            subTabBarItem.highlightIconColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
            viewController.tabBarItem = ESTabBarItem.init(subTabBarItem, title: title, image: UIImage(named: norName), selectedImage: UIImage(named: selectName))
            let navi = UINavigationController.init(rootViewController: viewController)
            viewControllers.append(navi)
            
        }
        self.viewControllers = viewControllers;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
