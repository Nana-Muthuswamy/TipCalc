//
//  TipViewController.swift
//  TipCalc
//
//  Created by Nana on 2/16/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

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

    // MARK: Utils

    private func updateUIFieldValues () -> Void {

        let selectedTipType = TipCalcEngine.TipType(rawValue: tipTypeControl.selectedSegmentIndex)! // Guaranteed return value

        if let inputBillAmount = Float(billAmount.text ?? ""), inputBillAmount > 0 {

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
            totalStack.removeArrangedSubview(totalFor1)
            splitTotalStack.isHidden = false
        case .Merge:
            totalStack.addArrangedSubview(totalFor1)
            splitTotalStack.isHidden = true
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
