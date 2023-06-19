//
//  AppDelegate.swift
//  CurrencyConverterApp
//
//  Created by Sandeep PV on 19/06/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn


@main
class AppDelegate: UIResponder, UIApplicationDelegate,UINavigationBarDelegate {


    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        redirectToHome()
        return true
    }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    func redirectToHome() {
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let homePage = mainStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        self.window?.rootViewController = homePage
        self.window?.makeKeyAndVisible()
//         self.window?.rootViewController.pushViewController(homePage, animated: false)
        
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


}

