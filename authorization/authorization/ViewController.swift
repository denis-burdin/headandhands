//
//  ViewController.swift
//  authorization
//
//  Created by Dennis Burdin on 06.08.17.
//  Copyright © 2017 headandhands. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var buttonSignIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        addLine(fromPoint: CGPoint(x: 15, y: textFieldEmail.frame.origin.y + textFieldEmail.frame.size.height), toPoint: CGPoint(x: 359, y: textFieldEmail.frame.origin.y + textFieldEmail.frame.size.height))
        addLine(fromPoint: CGPoint(x: 15, y: textFieldPassword.frame.origin.y + textFieldPassword.frame.size.height), toPoint: CGPoint(x: 359, y: textFieldPassword.frame.origin.y + textFieldPassword.frame.size.height))
        
        // make round corners for sign in button
        buttonSignIn.backgroundColor = UIColor(red: 1.00, green: 0.60, blue: 0.00, alpha: 1.00)
        buttonSignIn.layer.cornerRadius = buttonSignIn.frame.size.height / 2
        
        // make nav bar button empty
        let barButton = UIBarButtonItem()
        barButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
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
        
        if (validEmail && validPassword) {
            // show weather popup
            Alamofire.request("http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b1b15e88fa797225412429c1c50c122a1").responseJSON { response in
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                        let weather = json?["weather"] as! NSMutableArray
                        let forecast = weather[0] as! NSDictionary
                        let description = forecast["description"] as? String
                        
                        let alertController = UIAlertController(title: "Weather", message: description!, preferredStyle: UIAlertControllerStyle.alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            (result : UIAlertAction) -> Void in
                            print("OK")
                        }
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
        }
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
