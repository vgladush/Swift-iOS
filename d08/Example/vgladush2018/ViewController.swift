//
//  ViewController.swift
//  vgladush2018
//
//  Created by Dude-Rocker on 10/12/2018.
//  Copyright (c) 2018 Dude-Rocker. All rights reserved.
//

import UIKit
import vgladush2018

class ViewController: UIViewController {
    
    let articlemanager = ArticleManager()

    @IBAction func btnLoad(_ sender: UIButton) {
        print(articlemanager.getAllArticles())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("AM loaded")
        let art1 = articlemanager.newArticle()
        print("Art created")
        art1.title = "Art 1"
        art1.content = "Art 1 on d08"
        art1.created_at = NSDate()
        art1.updated_at = NSDate()
        art1.language = "en"
        print("before save")
        articlemanager.save()
        print("after save")
        
        let art2 = articlemanager.newArticle()
        art2.title = "Art 2"
        art2.content = "Art 2 from d08"
        art2.created_at = NSDate()
        art2.updated_at = NSDate()
        art2.language = "en"
        articlemanager.save()
        
        print(articlemanager.getAllArticles())
        print(articlemanager.getArticles(withLang: "en"))
        print(articlemanager.getArticles(containString: "on d08"))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

