//
//  ViewController.swift
//  ex02
//
//  Created by Vyacheslav GLADUSH on 01.10.2018.
//  Copyright © 2018 Vyacheslav GLADUSH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var checkLb: UILabel!
    
    
    @IBAction func but1(_ sender: UIButton) {
        print("1")
        checkLb.text = "1"
    }
    
    
    @IBAction func but2(_ sender: UIButton) {
        print("2")
        checkLb.text = "2"
    }
    
    @IBAction func but3(_ sender: UIButton) {
        print("3")
        checkLb.text = "3"
    }
    
    @IBAction func but4(_ sender: UIButton) {
        print("4")
        checkLb.text = "4"
    }
    
    @IBAction func but5(_ sender: UIButton) {
        print("5")
        checkLb.text = "5"
    }
    
    @IBAction func but6(_ sender: UIButton) {
        print("6")
        checkLb.text = "6"
    }
    
    @IBAction func but7(_ sender: UIButton) {
        print("7")
        checkLb.text = "7"
    }
    
    @IBAction func but8(_ sender: UIButton) {
        print("8")
        checkLb.text = "8"
    }
    
    @IBAction func but9(_ sender: UIButton) {
        print("9")
        checkLb.text = "9"
    }
    
    @IBAction func but0(_ sender: UIButton) {
        print("0")
        checkLb.text = "0"
    }
    
    @IBAction func butAc(_ sender: UIButton) {
        print("AC")
    }
    
    @IBAction func butNeg(_ sender: UIButton) {
        print("NEG")
    }
    
    @IBAction func butPlus(_ sender: UIButton) {
        print("+")
    }
    
    @IBAction func butMinus(_ sender: UIButton) {
        print("-")
    }
    
    @IBAction func butMult(_ sender: UIButton) {
        print("*")
    }
    
    @IBAction func butDiv(_ sender: UIButton) {
        print("/")
    }
    
    @IBAction func butAsign(_ sender: UIButton) {
        print("=")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

