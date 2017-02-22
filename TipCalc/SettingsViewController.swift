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

    // MARK: Action methods

    @IBAction func defaultTipTypeChanged(_ sender: UISegmentedControl) {

        UserPreferences.shared.preferredTipType = sender.selectedSegmentIndex
    }

    @IBAction func defaultTotalTypeChanged(_ sender: UISegmentedControl) {

        UserPreferences.shared.preferredTotalType = sender.selectedSegmentIndex
    }

    // MARK: UITextFieldDelegate

    func textFieldDidEndEditing(_ textField: UITextField) {

        if let input = textField.text {

            let userPref = UserPreferences.shared

            switch textField {

            case decentTip:
                userPref.preferredDecentTip = Float(input) ?? 0.0
            case happyTip:
                userPref.preferredHappyTip = Float(input) ?? 0.0
            case generousTip:
                userPref.preferredGenerousTip = Float(input) ?? 0.0
                
            default:
                break
            }
        }
    }

}
