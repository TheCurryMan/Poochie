//
//  SavedViewController.swift
//  Poochie
//
//  Created by Avinash Jain on 6/12/16.
//  Copyright © 2016 Avinash Jain. All rights reserved.
//

import UIKit
import Firebase

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var price: UILabel!
    
}

class SavedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var total : Int!
    var ref: FIRDatabaseReference!
    
    @IBOutlet var tableView: UITableView!
    
    var dataArray = [[""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(false, animated: false)
        
        var nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
        
        dataArray.removeAtIndex(0)
        
        ref = FIRDatabase.database().reference()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        
        
        ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            print(snapshot.value)
            
            if let y = snapshot.value as? [String:AnyObject] {
                
                let postDict = snapshot.value as! [String : AnyObject]
                
                if let obj =  postDict["totalitems"] as? Int {
                    
                    self.total = obj
                    for var i in 1...self.total {
                        var index = i - 1
                        print(index)
                        print(postDict["\(index)"])
                        var info = postDict["\(index)"] as! [String]
                        
                        self.dataArray.append(info)
                        
                        
                    }
                    self.tableView.reloadData()
                    
                }
                else {
                    self.total = 0
                }
                
                
               
                
            }
                
            else {
                self.total = 0
                
            }
            // ...
        })
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as! CustomTableViewCell
        
        // this is how you extract values from a tuple
        var content = dataArray[indexPath.row] as! [String]
        cell.title.text = content[3]
        cell.price.text = content[2]
        
        var ids = content[1]
        
        var arrs = ids.componentsSeparatedByString(",")
        //print(arrs)
        var finalId = arrs[0]
        finalId = String(finalId.characters.dropFirst())
        finalId = String(finalId.characters.dropFirst())
        //print(finalId)
        var photoURL = "http://images.craigslist.org/\(finalId)_300x300.jpg"
        //print(photoURL)
        
        cell.itemImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "\(photoURL)")!)!)
        return cell
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
