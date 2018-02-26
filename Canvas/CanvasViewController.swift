//
//  CanvasViewController.swift
//  Canvas
//
//  Created by siddhant on 2/26/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate{

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        trayDownOffset = 170
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    }
    

    @IBAction func didPanTray(_ sender: Any) {
        var trayOriginalCenter: CGPoint!
        trayOriginalCenter = trayView.center
        let location = (sender as AnyObject).location(in: view)
        let velocity = (sender as AnyObject).velocity(in: view)
        
        let translation = (sender as AnyObject).translation(in: view)
        
        if (sender as AnyObject).state == .began {
            print("Gesture began")
            trayOriginalCenter = trayView.center
            
        } else if (sender as AnyObject).state == .changed {
            print("Gesture is changing")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if (sender as AnyObject).state == .ended {
            print("Gesture ended")
            if (velocity.y > 0){
                //                UIView.animate(withDuration: 0.4) {
                //                    self.trayView.center = self.trayDown
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
                //                }
            } else {
                UIView.animate(withDuration: 0.4) {
                    self.trayView.center = self.trayUp
                }
            }
        }
    }
    @objc func faces(sender: UIPanGestureRecognizer){
        
        let translation = sender.translation(in: view)
        if sender.state == .began {
            print("Gesture began")
            newlyCreatedFace = sender.view as! UIImageView // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
            
        } else if sender.state == .changed {
            print("Gesture is changing")
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            print("Gesture ended")
            
        }
        
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
    
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(faces(sender:)))
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(sender:)))
            let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(sender:)))
            
            newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(rotateGestureRecognizer)
            
            
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            
        }
    }
    
    @objc func didPinch(sender: UIPinchGestureRecognizer) {
        
        if sender.state == .began {
            print("pinching")
            
            let scale = sender.scale
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFace.transform = (newlyCreatedFace.transform.scaledBy(x:scale, y: scale))
            sender.scale = 1
            
        } else if sender.state == .changed {
            print("pinching")
            let scale = sender.scale
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFace.transform = (newlyCreatedFace.transform.scaledBy(x:scale, y: scale))
            sender.scale = 1
            
        } else if sender.state == .ended {
            print("Gesture ended")
        }
        
    }
    
    @objc func didRotate(sender: UIRotationGestureRecognizer) {
        
        if sender.state == .began {
            print("rotating")
            
            let rotation = sender.rotation
            
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFace.transform = (newlyCreatedFace.transform.rotated(by: rotation))
            sender.rotation = 0
            
        } else if sender.state == .changed {
            print("rotating")
            
            let rotation = sender.rotation
            
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFace.transform = (newlyCreatedFace.transform.rotated(by: rotation))
            sender.rotation = 0
            
        } else if sender.state == .ended {
            print("Gesture ended")
        }
        
    }

    

}
