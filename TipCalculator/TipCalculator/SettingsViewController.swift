//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Chintan Rita on 9/9/15.
//  Copyright © 2015 Chintan Rita. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultTipPercentagesField: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSelectedTipValue()
    }
    
    func updateSelectedTipValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("tipcalculator_default_tip_index")
        
        defaultTipPercentagesField.selectedSegmentIndex = intValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onDefaultTipChanged(sender: AnyObject) {
        let selectedTipIndex = defaultTipPercentagesField.selectedSegmentIndex
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(selectedTipIndex, forKey: "tipcalculator_default_tip_index")
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateSelectedTipValue()
    }
}
