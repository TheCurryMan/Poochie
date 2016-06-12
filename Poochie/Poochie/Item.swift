//
//  Item.swift
//  Poochie
//
//  Created by Ben Ha on 6/11/16.
//  Copyright © 2016 Avinash Jain. All rights reserved.
//


import Foundation

class Item: NSObject{
    var name:String
    var price:Double
    var picture:String
    var location:String
    var email:String
    init( name:String, price:Double,picture:String,location:String,email:String){
        self.name = name
        self.price = price
        self.picture = picture
        self.location = location
        self.email = email
        
    }
    
}
