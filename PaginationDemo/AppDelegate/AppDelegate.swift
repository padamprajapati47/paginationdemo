//
//  AppDelegate.swift
//  PaginationDemo


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func startAnimation() {
        myActivityIndicator.tag = 1001
        myActivityIndicator.center = (UIApplication.topViewController()?.view.center)!
        
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
        UIApplication.topViewController()?.view.addSubview(myActivityIndicator)
    }
    
    func stopAnimation() {
        
        if let view = UIApplication.topViewController()?.view.viewWithTag(1001)
        {
            myActivityIndicator.isHidden = true
                  myActivityIndicator.stopAnimating()
            view.removeFromSuperview()
        }
      
    }

}

