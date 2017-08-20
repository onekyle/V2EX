//
//  VEXTabBarController.swift
//  V2EX
//
//  Created by Kyle on 21/8/17.
//  Copyright © 2017年 com.Kyle. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class VEXTabBarController: ESTabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        var viewControllers = [UINavigationController]()
        let itemsData = [
            ("Home", "home", "home_1"),
            ("Find", "find", "find_1"),
            ("More", "favor", "favor_1"),
            ("Message", "message", "message_1"),
            ("Me", "me", "me_1")]
        for (title, norName, selectName) in itemsData {
            
            let viewController = UIViewController()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
