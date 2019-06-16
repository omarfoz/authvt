//
//  AuthViewController.swift
//  virtual tourist
//
//  Created by Omar Yahya Alfawzan on 6/16/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication
import IBMMobileFirstPlatformFoundation

class AuthViewController: UIViewController{
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var authButton: UIButton!
    let activityView = UIActivityIndicatorView(style: .whiteLarge)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        authButton.layer.cornerRadius = 20
        activityView.center = self.view.center
        mainView.addSubview(activityView)
    }
    
    func setGradient() {
        let color1 = hexStringToUIColor(hex: "#065e86")
        let color2 = hexStringToUIColor(hex: "#dbdbdb")
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color2.cgColor, color1.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 2.6)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = mainView.layer.frame
        mainView.layer.insertSublayer(gradient, at: 0)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func localAuth(){
       
        
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // User authenticated successfully, take appropriate action
                            ServerAuth()
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
                            self.showFailureFromViewController(viewController: self, message: "Sorry!!... User did not authenticate successfully")
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                 self.showFailureFromViewController(viewController: self, message: "Sorry!!.. Could not evaluate policy.")
            }
        } else {
            // Fallback on earlier versions
            self.showFailureFromViewController(viewController: self, message: "Ooops!!.. This feature is not supported.")

     }
    func ServerAuth() {
        activityView.startAnimating()
          WLAuthorizationManager.sharedInstance().obtainAccessToken(forScope: nil) { (token, error) -> Void in
            if (error != nil) {
                // Start offilne mode !
                self.activityView.stopAnimating()
                self.showFailureFromViewController(viewController: self, message: "Did not recieve an access token from server, starting the app without authorization from server",withIdentifier: "auth")

                debugPrint("Did not recieve an access token from server: " + error.debugDescription)
                } else {
                self.activityView.stopAnimating()
                    self.performSegue(withIdentifier: "auth", sender: self)
                     self.showFailureFromViewController(viewController: self, message: "Recieved the following access token value")
                    debugPrint("Recieved the following access token value: " + (token?.value)!)
                    
                }
                
            }
            
        }
     }
    @IBAction func auth(_ sender: Any) {
        localAuth()
    }
}
