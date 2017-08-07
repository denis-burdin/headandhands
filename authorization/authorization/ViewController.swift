//
//  ViewController.swift
//  authorization
//
//  Created by Dennis Burdin on 06.08.17.
//  Copyright © 2017 headandhands. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var buttonSignIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        addLine(fromPoint: CGPoint(x: 15, y: 255), toPoint: CGPoint(x: 359, y: 255))
        addLine(fromPoint: CGPoint(x: 15, y: 312), toPoint: CGPoint(x: 359, y: 312))
        
        // make round corners for sign in button
        buttonSignIn.backgroundColor = UIColor(red: 1.00, green: 0.60, blue: 0.00, alpha: 1.00)
        buttonSignIn.layer.cornerRadius = buttonSignIn.frame.size.height / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
    }
    
    @IBAction func actionEnter(_ sender: Any) {

        // hide keyboard
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()

        // validate email
        let RegexEmail = "^[\\w!#$%&'*+\\-/=?\\^_`{|}~]+(\\.[\\w!#$%&'*+\\-/=?\\^_`{|}~]+)*@((([\\-\\w]+\\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\\.){3}[0-9]{1,3}))$"
        let TestResultEmail = NSPredicate.init(format:"SELF MATCHES %@",RegexEmail)
        let validEmail = TestResultEmail.evaluate(with: textFieldEmail.text!)
        
        if (!validEmail) {
            textFieldEmail.text = nil
        }
        
        // validate password
        // minimum six characters, at least one uppercase letter, one lowercase letter and one number
        let RegexPassword = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{6,}$"
        let TestResultPasssword = NSPredicate.init(format:"SELF MATCHES %@",RegexPassword)
        let validPassword = TestResultPasssword.evaluate(with: textFieldPassword.text!)
        
        if (!validPassword) {
            textFieldPassword.text = nil
        }
        
        //if (validEmail && validPassword) {
            // show weather popup
            let alertController = UIAlertController(title: "Weather", message: "Fuck you!", preferredStyle: UIAlertControllerStyle.alert)

            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        //}
    }
    
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.lightGray.cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.view.layer.addSublayer(line)
    }
}

extension ViewController: UITextFieldDelegate {

}
