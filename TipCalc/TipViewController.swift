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

    // Weak reference to Timer (current RunLoop will hold strong reference and removes it automatically)
    weak var timerToUpdateUIFields: Timer?

    
    // MARK: Method Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        updateUIFieldValues()
    }

    @IBAction func totalTypeChanged(_ sender: UISegmentedControl) {
    }

    // MARK: Utils

    private func updateUIFieldValues () -> Void {

        let selectedTipType = TipCalcEngine.TipType(rawValue: tipTypeControl.selectedSegmentIndex)! // Guaranteed return value

        if let inputBillAmount = Float(billAmount.text ?? "") {

            let result = engine.calculatTipAndTotals(billAmount: inputBillAmount, tipType: selectedTipType)

            tipAmount.text = "\(result.tipAmount)"
            totalFor1.text = "\(result.totalFor1)"
            totalFor2.text = "\(result.totalFor2)"
            totalFor3.text = "\(result.totalFor3)"
            totalFor4.text = "\(result.totalFor4)"

        }
    }

}

