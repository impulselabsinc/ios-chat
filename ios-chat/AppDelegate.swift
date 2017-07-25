//
//  AppDelegate.swift
//  ios-chat
//
//  Created by Nikhil Prabhakar on 7/19/17.
//  Copyright © 2017 Impulse Labs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    // Google URL Handler
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey:Any] = [:]) -> Bool {
        
        // put in handlers for any supported identity provider
        let googleHandler = GIDSignIn.sharedInstance().handle(
            url,
            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        // return the openURL result from any one identity provider
        return googleHandler
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Start Google SignIn modifications
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services \(String(describing: configureError))")
        
        GIDSignIn.sharedInstance().delegate = self
        // End Google SignIn modifications
        
        //add any other identity provider launch options
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            GIDSignIn.sharedInstance().signOut()
            
        }
    }
    
    // MARK: Google SignIn methods
    func sign(_ signIn:GIDSignIn!, didSignInFor user:GIDGoogleUser!, withError error: Error!){
        if let error = error {
            print("\(error.localizedDescription)")
            
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo: nil)
            
        } else{
            
            var imageUrl = ""
            if user.profile.hasImage{
                imageUrl = user.profile.imageURL(withDimension: 100).absoluteString
            }
            
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo: ["userID":user.userID,
                           "profileName":user.profile.name,
                           "profileEmail":user.profile.email,
                           "profileGivenName": user.profile.givenName,
                           "profileFamilyName":user.profile.familyName,
                           "profileHasImage": user.profile.hasImage,
                           "profileImageUrl":imageUrl])
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!){
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: nil)
    }
    

}

