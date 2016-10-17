//
//  MenuType.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 13/10/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

class MenuType: UIView {

    // Our custom view from the XIB file
    var view: UIView!

    override init(frame: CGRect) {
        // 1. setup any properties here

        // 2. call super.init(frame:)
        super.init(frame: frame)

        // 3. Setup view from .xib file
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here

        // 2. call super.init(coder:)
        super.init(coder: aDecoder)

        // 3. Setup view from .xib file
        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromNib()

        // use bounds not frame or it'll be offset
        view.frame = bounds

        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]

        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        return loadView(withName: "")
    }

    func loadView(withName nibName: String) -> UIView {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)

        // Assumes UIView is top level and only object in AddMenu.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}

/*class DesignableXibView: UIView {

 var contentView : UIView?

 override init(frame: CGRect) {
 super.init(frame: frame)
 xibSetup()
 }

 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 xibSetup()
 }

 func xibSetup() {
 contentView = loadViewFromNib()

 // use bounds not frame or it'll be offset
 contentView!.frame = bounds

 // Make the view stretch with containing view
 contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]

 // Adding custom subview on top of our view (over any custom drawing > see note below)
 addSubview(contentView!)
 }

 func loadViewFromNib() -> UIView! {

 let bundle = Bundle(for: type(of: self))
 let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
 let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
 
 return view
 }
 
 }*/