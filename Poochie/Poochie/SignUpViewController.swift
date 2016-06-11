//
//  SignUpViewController.swift
//  Poochie
//
//  Created by Avinash Jain on 6/11/16.
//  Copyright © 2016 Avinash Jain. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signup(sender: AnyObject) {
        if let em = email.text, pass = password.text{
            FIRAuth.auth()?.createUserWithEmail(email.text!, password: password.text!) {(user, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    print("User signed in!")
                    
                    self.ref.child("data/users").updateChildValues(["\(FIRAuth.auth()!.currentUser!.uid)":["Username":self.username.text!]])
                    
                    self.performSegueWithIdentifier("home", sender: self)
                }
            } }
        else{
            print("You left email/password empty")
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
