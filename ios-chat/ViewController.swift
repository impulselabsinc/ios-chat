//
//  ViewController.swift
//  ios-chat
//
//  Created by Nikhil Prabhakar on 7/19/17.
//  Copyright © 2017 Impulse Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController , GIDSignInUIDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

