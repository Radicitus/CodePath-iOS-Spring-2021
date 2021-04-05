//
//  SettingsViewController.swift
//  Prework
//
//  Created by Cameron Sherry on 3/9/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isDarkMode = defaults.bool(forKey: "isDarkMode")
        if isDarkMode {
            overrideUserInterfaceStyle = .dark
            darkModeSwitch.isOn = true
        } else {
            overrideUserInterfaceStyle = .light
            darkModeSwitch.isOn = false
        }
    }
    
    @IBAction func darkModeToggle(_ sender: Any) {
        let isDarkMode = defaults.bool(forKey: "isDarkMode")
        
        if isDarkMode {
            darkModeSwitch.isOn = false
            overrideUserInterfaceStyle = .light
            defaults.set(false, forKey: "isDarkMode")
        } else {
            darkModeSwitch.isOn = true
            overrideUserInterfaceStyle = .dark
            defaults.set(true, forKey: "isDarkMode")
        }
        
        defaults.synchronize()
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
