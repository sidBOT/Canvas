//
//  CanvasViewController.swift
//  Canvas
//
//  Created by siddhant on 2/26/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanTray(_ sender: Any) {
        let translation = (sender as AnyObject).translation(in: view)

    }
    

}
