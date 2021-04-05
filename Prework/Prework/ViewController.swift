//
//  ViewController.swift
//  Prework
//
//  Created by Cameron Sherry on 3/9/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitSlider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var splitTotalAmountLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    var total = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Tip Calculator"
        billAmountTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isDarkMode = defaults.bool(forKey: "isDarkMode")
        if isDarkMode {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }

    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double (billAmountTextField.text!) ?? 0

        let tipPercentages = [0.15, 0.18, 0.2]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        total = bill + tip
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        if Int(splitSlider.value) > 0 {
            splitTotalAmountLabel.text = String(format: "$%.2f", total / Double(splitSlider.value))
        }
    }
    
    @IBAction func changeSplitValue(_ sender: Any) {
        let currentSliderVal = Int(splitSlider.value)
        
        if currentSliderVal > 0 {
            splitTotalLabel.isHidden = false
            splitTotalAmountLabel.isHidden = false
            sliderLabel.text = "Split between: \(currentSliderVal)"
        } else {
            splitTotalLabel.isHidden = true
            splitTotalAmountLabel.isHidden = true
            sliderLabel.text = "Currently not split"
        }
        
        splitTotalAmountLabel.text = String(format: "$%.2f", total / Double(currentSliderVal))
    }
}
