//
//  TestView.swift
//  EPDeckView
//
//  Created by Evangelos Pittas on 26/02/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import EPDeckView
import Font_Awesome_Swift


class TestView: EPCardView {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet var Location: UILabel!
    @IBOutlet var Price: UILabel!
    @IBOutlet var activityController: UIActivityIndicatorView!

    // MARK: INITIALIZATION
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
    }

    
    // MARK: XIB SETUP
    func xibSetup() {
        self.view = self.loadViewFromNib()
        self.view.frame = bounds
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        self.addSubview(self.view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TestView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        print("LOADING FROM NIB")
        self.checkButton.setFAIcon(FAType.FAHeart, iconSize: 60, forState: UIControlState.Normal)
        self.checkButton.setFATitleColor(UIColor.redColor())
        
        self.cancelButton.setFAIcon(FAType.FATimes, iconSize: 60, forState: UIControlState.Normal)
        self.cancelButton.setFATitleColor(UIColor.redColor())
        //self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2
        //self.profileImageView.layer.masksToBounds = true
        return view
    }
}


extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}




















