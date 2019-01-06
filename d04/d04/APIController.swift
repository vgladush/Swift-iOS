//
//  APIController.swift
//  d04
//
//  Created by Vyacheslav GLADUSH on 05.10.2018.
//  Copyright © 2018 Vyacheslav GLADUSH. All rights reserved.
//

import Foundation


class APIController {
    var delegate : APITwitterDelegate?
    let token : String

    init(deleg : APITwitterDelegate, tok: String) {
        self.delegate = deleg
        self.token = tok
    }
    
    func queryRequest(dict: String){
        let info = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(dict)&count=100&lang=en&result_type=recent".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        
        var url = URLRequest(url: info!)
        url.httpMethod = "GET"
        url.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.error(er: error! as NSError)
            }
            else
            {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    print(dic)
                    var t : [Tweet] = []
                    let statuses: [NSDictionary] = (dic["statuses"] as? [NSDictionary])!
                    for d in statuses {
                        let name = d["user"] as! NSDictionary
                        let date = d["created_at"]
                        let text = d["text"]
                        t.append(Tweet(name: name.value(forKey: "name")! as! String, text: text! as! String, date: date! as! String))
                    }
                    self.delegate?.apiTwitter(name: t)
                }
                catch let err
                {
                    print(err)
                }
            }
        }
        task.resume()
    }

}
