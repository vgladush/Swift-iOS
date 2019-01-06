//
//  ViewController.swift
//  d03
//
//  Created by Ivan BOHONOSIUK on 04.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollMy: UIScrollView!
    var imageView : UIImageView?
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView = UIImageView(image: image)
        scrollMy.addSubview(imageView!)
        scrollMy.contentSize = (imageView?.frame.size)!
        scrollMy.maximumZoomScale = 100
    }
    
    func setZoomScale() {
        
        var minZoom = min(self.view.bounds.size.width / imageView!.bounds.size.width, self.view.bounds.size.height / imageView!.bounds.size.height);
        
        if (minZoom > 1.0) {
            minZoom = 1.0;
        }
        
        scrollMy.minimumZoomScale = minZoom;
        scrollMy.zoomScale = minZoom;
        
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }


}

