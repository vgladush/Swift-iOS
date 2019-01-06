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
   
    var oper = false;
    var act = false;
    var type = 0;
    var val1:CLong = 0;
    var val2:CLong = 0;
    
    @IBAction func butt(_ sender: UIButton) {
        if (oper) {
            oper = false;
            val1 = 0;

            if (type == 16) {
                val2 = 0;
            }
            else {
                act = true;
            }
        }
        if ((val1 >= 0 && (val1 * 10 + sender.tag) < 2147483648) || (val1 < 0 && (val1 * 10 - sender.tag) > -2147483649)) {
            if (val1 < 0) {
                val1 = val1 * 10 - sender.tag;
            }
            else {
                val1 = val1 * 10 + sender.tag;
            }
        }
        else {
            if (val1 >= 0) {
                val1 = 2147483647;
                print("Error : max Int");
            }
            else {
                val1 = -2147483648;
                print("Error : min Int");
            }
        }
        checkLb.text = String(val1);
    }
    
    func actionOp() {
        if (type == 12) {
            if (val1 + val2 > 2147483647) {
                val1 = 2147483647;
                print("Error : max Int");
            }
            else if (val1 + val2 < -2147483648) {
                val1 = -2147483648;
                print("Error : min Int");
            }
            else {
                val1 = val1 + val2;
            }
        }
        else if (type == 13) {
            if (val1 * val2 > 2147483647) {
                val1 = 2147483647;
                print("Error : max Int");
            }
            else if (val1 * val2 < -2147483648) {
                val1 = -2147483648;
                print("Error : min Int");
            }
            else {
                val1 = val1 * val2;
            }
        }
        else if (type == 14) {
            if (val2 - val1 > 2147483647) {
                val1 = 2147483647;
                print("Error : max Int");
            }
            else if (val2 - val1 < -2147483648) {
                val1 = -2147483648;
                print("Error : min Int");
            }
            else {
                val1 = val2 - val1;
            }
        }
        else if (type == 15) {
            val1 = val2 / val1;
        }
        checkLb.text = String(val1);
    }
    
    @IBAction func operation(_ sender: UIButton) {
        oper = true;
        if (act || sender.tag == 16) {
            if (type == 15 && val1 == 0) {
                checkLb.text = "Error";
                val1 = 0;
                val2 = 0;
                type = 0;
                act = false;
                oper = false;
            }
            else {
                actionOp();
            }
            act = false;
            val2 = val1;
        }
        else {
            val2 = val1;
        }
        type = sender.tag;
    }
    
    @IBAction func AcOp(_ sender: UIButton) {
        val1 = 0;
        val2 = 0;
        checkLb.text = "0";
        type = 0;
        act = false;
        oper = false;
    }
    
    @IBAction func negOp(_ sender: UIButton) {
        if ((val1 < 0 && val1 * -1 < 2147483648) || (val1 >= 0 && val1 * -1 > -2147483649)) {
            val1 = -val1;
        }
        else {
            if (val1 < 0) {
                val1 = 2147483647;
            }
            else {
                val1 = -2147483648;
            }
            print("Error : max or min Int");
        }
        checkLb.text = String(val1);
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

