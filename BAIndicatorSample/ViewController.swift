//
//  ViewController.swift
//  BAIndicatorSample
//
//  Created by Smart City on 1/22/19.
//  Copyright © 2019 Bosch. All rights reserved.
//

import UIKit
import BAIndicator

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view, typically from a nib.
        let width: CGFloat = 62.0
        let height: CGFloat = 62.0
        
        let baIndicator = BAIndicator(frame: CGRect(x: self.view.frame.size.width/2 - width/2, y: self.view.frame.size.height/2 - height/2, width: width, height: height), speed: .Fast)
        self.view.addSubview(baIndicator)
        baIndicator.startAmination()
    }


}

