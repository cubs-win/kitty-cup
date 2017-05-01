//
//  ViewController.swift
//  KittyCup
//
//  Created by Scott Kuhn on 3/31/17.
//  Copyright © 2017 kuhn. All rights reserved.
//

import UIKit

class HoleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        holeNumberLabel.text = "Hole # \(holeNumber!)"
        holeParLabel.text = "Par \(holePar!)"
        courseNameLabel.text = scoreCard!.course.name
        clubData = ["Driver", "3W", "5W", "Hybrid", "5i", "6i", "7i", "8i", "9i", "PW", "GW", "SW", "LW"]
        print("viewDidLoad and puttCountStepper value is \(puttCountStepper.value)")
        print("viewDidLoad and club count is \(clubData.count)")
        teeShotClubPicker.dataSource = self
        teeShotClubPicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print("pickerView numberOfComponents returning 1")
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("pickerView number of Rows in Component returning \(clubData.count)")
        return clubData.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("pickerView title for Row \(row) returning \(clubData[row])")
        return clubData[row]

    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Picker View Action: \(clubData[row]) selected!")
    }

    var holeNumber : Int?
    var holePar : Int?
    var scoreCard : Scorecard?
    
    @IBOutlet weak var teeShotClubPicker: UIPickerView!
    @IBOutlet weak var upAndDownYesButton: UIButton!
    @IBOutlet weak var upAndDownNoButton: UIButton!
    @IBOutlet weak var upAndDownNAButton: UIButton!
    @IBOutlet weak var holeParLabel: UILabel!
    @IBOutlet weak var holeNumberLabel: UILabel!
    @IBOutlet weak var puttCountLabel: UILabel!
    @IBOutlet weak var puttCountStepper: UIStepper!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    
    var clubData: [String] = [String]()
    

    
    @IBAction func yesUpAndDownPressed(_ sender: UIButton) {
        upAndDownYesButton.setTitleColor(UIColor.green, for:.normal)
        upAndDownNoButton.setTitleColor(UIColor.gray, for:.normal)
        upAndDownNAButton.setTitleColor(UIColor.gray, for:.normal)
        
    }
    
    @IBAction func noUpAndDownPressed(_ sender: UIButton) {
        upAndDownYesButton.setTitleColor(UIColor.gray, for:.normal)
        upAndDownNoButton.setTitleColor(UIColor.green, for:.normal)
        upAndDownNAButton.setTitleColor(UIColor.gray, for:.normal)

    }
    
    @IBAction func notApplicableUpAndDownPressed(_ sender: UIButton) {
        upAndDownYesButton.setTitleColor(UIColor.gray, for:.normal)
        upAndDownNoButton.setTitleColor(UIColor.gray, for:.normal)
        upAndDownNAButton.setTitleColor(UIColor.green, for:.normal)

    }
    
    @IBAction func puttsCountChanged(_ sender: UIStepper, forEvent _: UIEvent) {
        let value = sender.value;
        puttCountLabel.text = String(Int(value))
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let row = teeShotClubPicker.selectedRow(inComponent:0)
        print("Save button pressed w/ Club selected: \(clubData[row])")
    }
}

