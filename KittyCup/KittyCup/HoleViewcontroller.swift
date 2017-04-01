//
//  ViewController.swift
//  KittyCup
//
//  Created by Scott Kuhn on 3/31/17.
//  Copyright © 2017 kuhn. All rights reserved.
//

import UIKit

class HoleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        holeNumberLabel.text = "Hole # \(holeNumber!)"
        holeParLabel.text = "Par \(holePar!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var holeNumber : Int?
    var holePar : Int?
    
    @IBOutlet weak var holeParLabel: UILabel!
    @IBOutlet weak var holeNumberLabel: UILabel!
}

