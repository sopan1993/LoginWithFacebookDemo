//
//  ViewController.swift
//  FBLoginDemo
//
//  Created by Shirish Vispute on 25/02/19.
//  Copyright © 2019 Bitware Technologies. All rights reserved.
//

import UIKit
import  FacebookLogin
import  FacebookCore
import  FBSDKLoginKit

class ViewController: UIViewController {

    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //creating button
//        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        loginButton.center = view.center
//
//        //adding it to view
//        view.addSubview(loginButton)
        
        //if the user is already logged in
        if FBSDKAccessToken.current() != nil{
            getFBUserData()
        }
    }

    //when login button clicked
  
    @IBAction func fbLoginAction(_ sender: Any) {
        let loginManager:FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email","public_profile"], from: self){
            (result,error) -> Void in
            if error == nil
            {
                let loginResult:FBSDKLoginManagerLoginResult = result!
                if loginResult.grantedPermissions != nil
                {
                    if loginResult.grantedPermissions.contains("email")
                    {
                        self.getFBUserData()
                    }
                }
                else
                {
                    
                }
            }
            else
            {
                
            }
        }
    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as? [String : AnyObject]
                    print(result!)
                   // print(self.dict!)
                }
            })
        }
    }
}
