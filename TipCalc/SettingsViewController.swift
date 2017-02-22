//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Nana on 2/21/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var decentTip: UITextField!
    @IBOutlet weak var happyTip: UITextField!
    @IBOutlet weak var generousTip: UITextField!

    @IBOutlet weak var tipType: UISegmentedControl!
    @IBOutlet weak var totalType: UISegmentedControl!

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load user preference values
        let userPref = UserPreferences.shared

        decentTip.text = "\(userPref.preferredDecentTip)"
        happyTip.text = "\(userPref.preferredHappyTip)"
        generousTip.text = "\(userPref.preferredGenerousTip)"

        tipType.selectedSegmentIndex = userPref.preferredTipType
        totalType.selectedSegmentIndex = userPref.preferredTotalType
    }

}
