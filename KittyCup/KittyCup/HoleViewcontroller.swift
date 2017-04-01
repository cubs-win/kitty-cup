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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var holeNumber : Int?
    
    @IBOutlet weak var holeNumberLabel: UILabel!
}

