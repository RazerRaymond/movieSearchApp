//
//  SettingsViewController.swift
//  MSA
//
//  Created by Mac for Rav on 10/21/19.
//  Copyright © 2019 RayZhang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var adultSwitch: UISwitch!
    @IBOutlet weak var languageSegment: UISegmentedControl!
    
    @IBAction func changeContent(_ sender: Any) {
        let adult = UserDefaults.standard.bool(forKey: "adultSwitch")
        if adult == true{
            UserDefaults.standard.set(false, forKey: "adultSwitch")
        }
        else{
            UserDefaults.standard.set(true, forKey: "adultSwitch")
        }
    }
    @IBAction func changeLanguage(_ sender: Any) {
        switch languageSegment.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set("en", forKey: "languageSelect")
        case 1:
            UserDefaults.standard.set("es", forKey: "languageSelect")
        case 2:
            UserDefaults.standard.set("zh", forKey: "languageSelect")
        case 3:
            UserDefaults.standard.set("fr", forKey: "languageSelect")
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
