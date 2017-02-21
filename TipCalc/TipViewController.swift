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

    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var totalStack: UIStackView!
    @IBOutlet weak var splitTotalStack: UIStackView!

    enum TotalType: Int {
        case Split
        case Merge
    }

    // Calc Engine
    let engine = TipCalcEngine()

    // Weak reference to Timers (current RunLoop will hold strong reference and removes it automatically)
    // The Timer to delay updating totals for better user experience
    weak var timerToUpdateUIFields: Timer?

    // MARK: Method Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        // TDO: Need to replace this with locale currency symbol
        billAmount.text = "$"

        // Displays the keypad
        showKeyPad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        // Update UI to display either Merged Total or Split Totals
        updateUI(for: TotalType.init(rawValue: sender.selectedSegmentIndex)!)
    }

    // MARK: UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var canChange = true

        if string == "" && textField.text! == "$" {
            canChange = false
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

    private func updateUI(for totalType: TotalType) -> Void {

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

    private func hideKeyPad() -> Void {
        // Hides the keypad
        billAmount.resignFirstResponder()
    }

    private func showKeyPad() -> Void {
        // Displays the keypad
        billAmount.becomeFirstResponder()
    }
}
