//
//  ViewController.swift
//  ios-chat
//
//  Created by Nikhil Prabhakar on 7/19/17.
//  Copyright © 2017 Impulse Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController , GIDSignInUIDelegate{

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var loginMessage: UILabel!
    let signOutButton: UIBarButtonItem = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //Google SignIn
        setupSignOutButton()
        disconnectButton.isHidden = true
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signInSilently()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.receiveToggleAuthUINotification(_:)),
                                               name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                               object:nil)
        
        //color the view
        self.view.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 205/255, alpha: 1.0)
        // color the navbar
        navBar.topItem?.title = "Impulse Labs Demo"
        navBar.topItem?.prompt = "Friendly gneiss will countermand my kaftan"
        navBar.backgroundColor = UIColor(red: 150/255, green: 195/255, blue: 150/255, alpha: 1.0)
        
        //signInButton.colorScheme = GIDSignInButtonColorScheme.light
    
        toggleAuthUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Google Auth funcs
    func setupSignOutButton(){
        navBar.topItem?.rightBarButtonItem = signOutButton
        navBar.topItem?.rightBarButtonItem?.target = self
        navBar.topItem?.rightBarButtonItem?.action = #selector(ViewController.signOut(_:))
    }
    
    func toggleAuthUI(){
        GIDSignIn.sharedInstance().scopes = ["https://www.googleapis.com/auth/userinfo.email","https://www.googleapis.com/auth/userinfo.profile","https://www.googleapis.com/auth/plus.me"]
        if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            //signed in
            self.view.backgroundColor = UIColor(red: 150/255, green: 200/255, blue: 150/255, alpha: 1.0)
            navBar.topItem?.rightBarButtonItem?.isEnabled = true
            navBar.topItem?.rightBarButtonItem?.title = "Sign Out"
            signInButton.isHidden = true
            if let profileName = UserDefaults.standard.string(forKey: "profileName") {
                loginMessage.textColor = UIColor(red: 255/255, green: 69/255, blue: 0/255, alpha: 1.0)
                loginMessage.text = "You are logged in as \n\(profileName)"
            }
            
            
        }else{
            //signed out
            self.view.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 200/255, alpha: 1.0)
            navBar.topItem?.rightBarButtonItem?.isEnabled = false
            navBar.topItem?.rightBarButtonItem?.title = ""
            signInButton.isHidden = false
            loginMessage.textColor = UIColor(red: 255/255, green: 69/255, blue: 0/255, alpha: 1.0)
            loginMessage.text = "You are not logged in"
        }
    }
    
    func signOut(_ sender: AnyObject){
        GIDSignIn.sharedInstance().signOut()
        UserDefaults.standard.removeObject(forKey: "profileName")
        toggleAuthUI()
    }
    
    @IBAction func disconnectAccount(_ sender: Any) {
        GIDSignIn.sharedInstance().disconnect()
        UserDefaults.standard.removeObject(forKey: "profileName")
        toggleAuthUI()
    }
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification){
        if notification.name.rawValue == "ToggleAuthUINotification" {
            
            if notification.userInfo != nil {
                if let username = notification.userInfo?["profileName"] as? String {
                    UserDefaults.standard.setValue(username, forKey: "profileName")
                }
                
            }
            self.toggleAuthUI()
        }
    }

}

// required for unit testing - because you should not call loadView() directly
// https://www.natashatherobot.com/ios-testing-view-controllers-swift/
extension UIViewController{
    func preloadView(){
        _ = view
    }
}
