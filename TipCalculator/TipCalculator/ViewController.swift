//
//  ViewController.swift
//  TipCalculator
//
//  Created by Chintan Rita on 9/9/15.
//  Copyright © 2015 Chintan Rita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.22]
        let selectedTipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount: Double = NSString(string: billField.text!).doubleValue
        let tip = billAmount * selectedTipPercentage
        let totalAmount = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", totalAmount)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

