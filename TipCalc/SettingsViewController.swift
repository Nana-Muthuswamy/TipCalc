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

        // Add Tap Gesture to UITableView to order out Keypad
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tableView.addGestureRecognizer(tapGesture)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Save user edited values
        UserPreferences.shared.saveUserPreferences()
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
        view.endEditing(true)
    }

    func handleTap(tapGesture: UITapGestureRecognizer) -> Void {
        hideKeyPad()
    }
}
