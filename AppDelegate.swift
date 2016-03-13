//
//  AppDelegate.swift
//  flicker
//
//  Created by victor aguirre on 3/7/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit
import SwiftHEXColors

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var colorBlack: UIColor = UIColor.blackColor()
    var colorWhite: UIColor = UIColor.whiteColor()
    var colorPrincipal: UIColor = UIColor(hexString: "#3F51B5")!
    var colorSecundary: UIColor = UIColor(hexString: "#E3F2FD")!
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let nowPlayingNavigationController = storyBoard.instantiateViewControllerWithIdentifier("MoviesNavigationController") as! UINavigationController
        let nowPlayingViewController = nowPlayingNavigationController.topViewController as! MoviesViewController
        //set the param for the API
        nowPlayingViewController.endPoint = "now_playing"
        //customization tab bar
        nowPlayingNavigationController.tabBarItem.title = "Now Playing"
        nowPlayingNavigationController.tabBarItem.image = UIImage(named: "now_playing")
        
        let topRatedNavigationController = storyBoard.instantiateViewControllerWithIdentifier("MoviesNavigationController") as! UINavigationController
        let topRatedViewController = topRatedNavigationController.topViewController as! MoviesViewController
        topRatedViewController.endPoint = "top_rated"
        topRatedNavigationController.tabBarItem.title = "Top Rated"
        topRatedNavigationController.tabBarItem.image = UIImage(named: "top_rated")

        //start the tab bar
        let tabBarController = UITabBarController()
        //put the number of view in the tab
        tabBarController.viewControllers = [nowPlayingNavigationController,topRatedNavigationController]
        
        UINavigationBar.appearance().barTintColor = colorPrincipal
        UINavigationBar.appearance().tintColor = colorWhite
        UINavigationBar.appearance().alpha  = 0.8
        UINavigationBar.appearance().translucent = true
        
        UITabBar.appearance().tintColor = colorWhite
        UITabBar.appearance().barTintColor = colorPrincipal
        UITabBar.appearance().alpha = 0.8
       
        //set the tab bar in the root view controller
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits var application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

