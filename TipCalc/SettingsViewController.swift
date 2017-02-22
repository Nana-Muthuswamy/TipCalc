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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        super.touchesBegan(touches, with: event)

        hideKeyPad()
    }

    // MARK: Action methods

    @IBAction func defaultTipTypeChanged(_ sender: UISegmentedControl) {

        hideKeyPad()

        UserPreferences.shared.preferredTipType = sender.selectedSegmentIndex
    }

    @IBAction func defaultTotalTypeChanged(_ sender: UISegmentedControl) {

        hideKeyPad()

        UserPreferences.shared.preferredTotalType = sender.selectedSegmentIndex
    }

    // MARK: UITextFieldDelegate

    func textFieldDidEndEditing(_ textField: UITextField) {

        if let input = textField.text {

            let userPref = UserPreferences.shared

            switch textField {

            case decentTip:
                userPref.preferredDecentTip = Int(input) ?? 0
            case happyTip:
                userPref.preferredHappyTip = Int(input) ?? 0
            case generousTip:
                userPref.preferredGenerousTip = Int(input) ?? 0
                
            default:
                break
            }
        }
    }

    // MARK: Utils

    func hideKeyPad() -> Void {
        // Hides key pad and force updates user preferred value
        decentTip.resignFirstResponder()
        happyTip.resignFirstResponder()
        generousTip.resignFirstResponder()
    }

}
