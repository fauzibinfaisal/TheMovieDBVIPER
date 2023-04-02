//
//  TopViewControllerGettable.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import UIKit

extension UIApplication {
    var topViewController: UIViewController?{
        
        var pointedViewController = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController
        
        while  pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
    }
}

protocol TopViewControllerGettable  {
    var topViewController: UIViewController? { get }
    var topNavController: UINavigationController? { get }
    var topTabController: UITabBarController? { get }
}

extension TopViewControllerGettable {
    var topViewController: UIViewController? {
        return UIApplication.shared.topViewController
    }
    
    var topNavController: UINavigationController? {
        return UIApplication.shared.topViewController as? UINavigationController
        
    }
    
    var topTabController: UITabBarController? {
        return UIApplication.shared.topViewController as? UITabBarController
    }
}

class Router: TopViewControllerGettable { }

