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

    override var viewControllers: [UIViewController]? {
        didSet {
            transitionAnimator.viewControllers = viewControllers
        }
    }
    
    let transitionAnimator = TabBarControllerTransitionAnimator()
    
    
    
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
        self.delegate = self;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionAnimator
    }
    
}

class TabBarControllerTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var viewControllers: [UIViewController]?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let viewControllers = viewControllers, let fromViewController = transitionContext.viewController(forKey: .from), let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        
        
        guard let fromIndex = viewControllers.index(of: fromViewController), let toIndex = viewControllers.index(of: toViewController) else { return }
        
        var startX: CGFloat = 20.0
        
        if fromIndex < toIndex {
            startX = -startX
        }
        
        guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to) else { return }
        
        let containView = transitionContext.containerView
        toView.frame = CGRect(x: -startX, y: 0, width: containView.frame.width, height: containView.frame.height)
        toView.alpha = 0.0;
        containView.addSubview(fromView)
        containView.addSubview(toView)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { 
            fromView.transform = fromView.transform.translatedBy(x: startX, y: 0)
            fromView.alpha = 0.0
            toView.transform = toView.transform.translatedBy(x: startX, y: 0)
            toView.alpha = 1.0
        }) { (_) in
            fromView.alpha = 1.0
            transitionContext.completeTransition(true)
        };
    }
    
}
