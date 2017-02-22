//
//  TipViewController.swift
//  TipCalc
//
//  Created by Nana on 2/16/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipTypeControl: UISegmentedControl!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalTypeControl: UISegmentedControl!

    @IBOutlet weak var totalFor1: UILabel!
    @IBOutlet weak var totalFor2: UILabel!
    @IBOutlet weak var totalFor3: UILabel!
    @IBOutlet weak var totalFor4: UILabel!

    @IBOutlet weak var totalStack: UIStackView!
    @IBOutlet weak var splitTotalStack: UIStackView!
    @IBOutlet weak var tipStack: UIStackView!


    enum TotalType: Int {
        case Split
        case Merge
    }

    enum ViewState {
        case Basic
        case Detail
    }

    // Keeps track of current View State
    var currentViewState = ViewState.Basic

    // Calc Engine
    let engine = TipCalcEngine()

    // Weak reference to Timers (current RunLoop will hold strong reference and removes it automatically)
    // The Timer to delay updating totals for better user experience
    weak var timerToUpdateUIFields: Timer?

    // MARK: Method Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set View Initial State
        tipStack.alpha = 0.0
        splitTotalStack.alpha = 0.0

        // TDO: Need to replace this with locale currency symbol
        billAmount.text = "$"

        showKeyPad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        super.touchesBegan(touches, with: event)

        hideKeyPad()
    }

    // MARK: IBActions

    @IBAction func billAmountChanged(_ sender: UITextField) {

        if let timer = self.timerToUpdateUIFields {
            timer.invalidate()
            timerToUpdateUIFields = nil
        }

        timerToUpdateUIFields = Timer.scheduledTimer(withTimeInterval: 0.45, repeats: false) {_ in
            self.updateUIFieldValues()
            self.timerToUpdateUIFields = nil;
        }
    }

    @IBAction func tipTypeChanged(_ sender: UISegmentedControl) {

        hideKeyPad()

        // Calculate new total and update the field values
        updateUIFieldValues()
    }

    @IBAction func totalTypeChanged(_ sender: UISegmentedControl) {

        hideKeyPad()

        // UI to display either Merged Total or Split Totals
        updateTotalsUI(TotalType.init(rawValue: sender.selectedSegmentIndex)!)
    }

    // MARK: UITextFieldDelegate
    // TDO: Need to handle Cut/Copy/Paste scenarios and deleting first digit by moving cursor
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        var canChange = true

        // When range.location is 0, do not allow edit. This is to retain the currency symbol always.
        if range.location == 0 {

            canChange = false
        }
        // When range.location is lesser than or equal to 1 and when range.length is greater than 0, all digits are cleared and thus view state should be set to Basic if it isn't already.
        else if range.location <= 1 && range.length > 0 {
            // Update the view layout to display basic details when no bill amount is entered
            if currentViewState != .Basic {updateUIState(.Basic)}

        }
        // In all other cases, the view state should be set to Detail if it isn't already
        else {

            // Update the view layout to display other details when bill amount is entered
            if currentViewState != .Detail {updateUIState(.Detail)}
        }

        return canChange
    }

    // MARK: Utils

    private func updateUIFieldValues () -> Void {

        let selectedTipType = TipCalcEngine.TipType(rawValue: tipTypeControl.selectedSegmentIndex)! // Guaranteed return value
        let inputBillAmountText = billAmount.text!.trimmingCharacters(in: CharacterSet(charactersIn:"$"))

        if let inputBillAmount = Float(inputBillAmountText), inputBillAmount > 0 {

            let result = engine.calculatTipAndTotals(billAmount: inputBillAmount, tipType: selectedTipType)

            tipAmount.text = String(format: "$%.2f", result.tipAmount)
            totalFor1.text = String(format: "$%.2f", result.totalFor1)
            totalFor2.text = String(format: "$%.2f", result.totalFor2)
            totalFor3.text = String(format: "$%.2f", result.totalFor3)
            totalFor4.text = String(format: "$%.2f", result.totalFor4)

        } else {

            tipAmount.text = " "
            totalFor1.text = " "
            totalFor2.text = " "
            totalFor3.text = " "
            totalFor4.text = " "
        }
    }

    private func updateTotalsUI(_ totalType: TotalType) -> Void {

        switch totalType {

        case .Split:
            UIView.animate(withDuration: 0.5, animations: {

                self.splitTotalStack.alpha = 1.0
                self.totalFor1.alpha = 0.0

            }, completion: { (completed) in

                self.totalStack.removeArrangedSubview(self.totalFor1)
            })

        case .Merge:
            self.totalStack.addArrangedSubview(self.totalFor1)

            UIView.animate(withDuration: 0.5, animations: {

                self.totalFor1.alpha = 1.0
                self.splitTotalStack.alpha = 0.0
            })
        }
    }

    private func updateUIState(_ newState: ViewState) -> Void {

        switch newState {

        case .Basic:
            UIView.animate(withDuration: 0.5, animations: { 
                self.tipStack.alpha = 0.0
                self.splitTotalStack.alpha = 0.0
            })

        case .Detail:

            UIView.animate(withDuration: 0.5, animations: {
                self.tipStack.alpha = 1.0

            }, completion: { (completed) in

                self.updateTotalsUI(TotalType.init(rawValue: self.totalTypeControl.selectedSegmentIndex)!)
            })
        }

        // reset the new view state
        currentViewState = newState
    }

    private func hideKeyPad() -> Void {
        // Implicitly Hides the keypad
        billAmount.resignFirstResponder()
    }

    private func showKeyPad() -> Void {
        // Implicitly Displays the keypad
        billAmount.becomeFirstResponder()
    }

    // MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "Settings") {
            let navigationItem = segue.destination.navigationItem
            navigationItem.title = "Settings"
        }
    }
}
