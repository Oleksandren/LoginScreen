//
//  LoginVC.swift
//  LoginScreen
//
//  Created by Oleksandr Nechet on 09.11.15.
//  Copyright © 2015 Oleksandr Nechet. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var viewSocialBtns: UIView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassw: UITextField!
    @IBOutlet weak var imageViewUserPhoto: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    var buttonSelected: OLNSocialButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewUserPhoto.layer.borderColor = UIColor.whiteColor().CGColor
        imageViewUserPhoto.layer.borderWidth = 2
        imageViewUserPhoto.layer.cornerRadius = imageViewUserPhoto.bounds.size.height / 2.0
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        buttonLogin.animationCircular(directionShow: true)
        viewSocialBtns.animationMoveUp(false, andHide: true)
    }
    
    //MARK: - IBActions
    
    @IBAction func endEditing(_: AnyObject) {
        if (buttonSelected != nil) {
            expandSocialButton(buttonSelected!)
            buttonSelected = nil
        } else {
            buttonLogin.animationCircular(directionShow: false)
            viewSocialBtns.animationMoveUp(false, andHide: false)
            self.view.endEditing(true)
        }
    }
    
    @IBAction func useSocial(sender: OLNSocialButton) {
        if sender.expanded {
            //Do Sign In
            switch sender.tag {
            case 101:
                print("fb")
            case 102:
                print("tw")
            case 103:
                print("q+")
            default:
                print("setup tags in Social buttons")
            }
        }else{
            //expand
            buttonSelected = sender
            expandSocialButton(sender)
        }
    }
    
    //MARK: - Animation logic
    
    func expandSocialButton(button: OLNSocialButton) {
        let willBeginExpanding = !button.expanded
        button.expand()
        
        //animated hide/show other social btns
        var btnsWillBeHidden = Set(button.superview!.subviews)
        btnsWillBeHidden.remove(button)
        for  btn in btnsWillBeHidden{
            btn.animationFade(directionFade: willBeginExpanding)
        }
        
        //animated move and hide/show textFields
        for  textField in [textFieldEmail, textFieldPassw]{
            textField.animationMoveUp(true, andHide: willBeginExpanding)
        }
        
        //animated show/hide user profile info
        imageViewUserPhoto.animationCircular(directionShow: willBeginExpanding, startTop: false)
        labelUserName.animationCircular(directionShow: willBeginExpanding, startTop: false)
    }
}
