//
//  ViewController.swift
//  d06
//
//  Created by Ivan BOHONOSIUK on 10/10/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var forms: [Form] = []
    var select: Form? = nil
    
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()
    let behaviour = UIDynamicItemBehavior()
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue.main

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = true
        let gPan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGesture(_:)))
        view.addGestureRecognizer(gPan)
        let gTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGesture(_:)))
        view.addGestureRecognizer(gTap)
        let gPin = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinGesture(_:)))
        view.addGestureRecognizer(gPin)
        let gRot = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotGesture(_:)))
        view.addGestureRecognizer(gRot)
        
        // Create the animator
        animator = UIDynamicAnimator(referenceView: view)
        gravity.gravityDirection = CGVector(dx:0, dy: 0.8)
        animator.addBehavior(gravity)
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        behaviour.elasticity = 0.5
        animator.addBehavior(behaviour)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if motionManager.isAccelerometerAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: gravityUpdated as! CMDeviceMotionHandler)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func gravityUpdated(motion: CMDeviceMotion!, error: NSError!) {
        if (error != nil) {
            NSLog("\(error)")
        }
        let grav : CMAcceleration = motion.gravity;
        
        let x = CGFloat(grav.x)
        let y = CGFloat(grav.y)
        let v = CGVector(dx: x,dy: y)
        gravity.gravityDirection = v
    }
    
    
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let newForm = Form()
            newForm.translatesAutoresizingMaskIntoConstraints = true
            newForm.center = sender.location(in: self.view)
            self.view.addSubview(newForm)
            //  upgrade size to 100
            UIView.animate(withDuration: 0.3) {
                newForm.bounds.size = CGSize(width: 100, height: 100)
            }
            forms.append(newForm)
            gravity.addItem(newForm)
            collision.addItem(newForm)
            behaviour.addItem(newForm)
        default:
            print("tap.default")
        }
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in forms {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                self.view.bringSubview(toFront: select!)
                gravity.removeItem(select!)
            }
        case .changed:
            if select != nil {
                select!.center = sender.location(in: self.view)
                animator.updateItem(usingCurrentState: select!)
            }
        default:
            if select != nil {
                gravity.addItem(select!)
                select = nil
            }
        }
    }
    
    @objc func pinGesture(_ sender: UIPinchGestureRecognizer) {
        var lastdist: CGFloat = 1
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in forms {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                gravity.removeItem(select!)
                self.view.bringSubview(toFront: select!)
                lastdist = sender.scale
            }
        case .changed:
            if select != nil {
                collision.removeItem(select!)
                select!.bounds.size = CGSize(width: 100*(sender.scale/lastdist), height: 100*(sender.scale/lastdist))
                animator.updateItem(usingCurrentState: select!)
                collision.addItem(select!)
            }
        default:
            if select != nil {
                print("pan.default \(select!.center)")
                gravity.addItem(select!)
                select = nil
            }
        }
    }
    
    @objc func rotGesture(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in forms {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                gravity.removeItem(select!)
                self.view.bringSubview(toFront: select!)
            }
        case .changed:
            if select != nil {
                select!.transform = select!.transform.rotated(by: sender.rotation)
                animator.updateItem(usingCurrentState: select!)
                sender.rotation = 0
            }
        default:
            if select != nil {
                gravity.addItem(select!)
                select = nil
            }
        }
    }


}

