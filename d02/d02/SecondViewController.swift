//
//  SecondViewController.swift
//  d02
//
//  Created by Sergiy SHILINGOV on 10/4/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var dateField: UIDatePicker!
    
    
    @IBAction func doneBtn(_ sender: Any) {
        if let name = nameField.text {
            print(name)
        }
        if let description = descriptionField.text {
            print(description)
        }
        let format = DateFormatter()
        format.dateFormat = "dd MMMM yyyy HH:mm:ss"
        let date  = format.string(from: dateField.date)
        print(date)
        if nameField.text != "" {
            
            performSegue(withIdentifier: "toFirstView", sender: self)
//            _ = navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let format = DateFormatter()
        format.dateFormat = "dd MMMM yyyy HH:mm:ss"
        let date  = format.string(from: dateField.date)
        Data.names.append((nameField.text!, descriptionField.text!, date))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateField.minimumDate = Date()
        nameField.placeholder = "name"
        descriptionField.layer.borderWidth = 1
        descriptionField.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
