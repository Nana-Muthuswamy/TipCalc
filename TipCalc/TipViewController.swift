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

    // Calc Engine
    let engine = TipCalcEngine()

    
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
        print("Bill: \(sender.text!)")
        updateUIFields()
    }

    @IBAction func tipTypeChanged(_ sender: UISegmentedControl) {
        updateUIFields()
    }

    @IBAction func totalTypeChanged(_ sender: UISegmentedControl) {
    }

    // MARK: Utils

    private func updateUIFields () -> Void {

        let selectedTipType = TipCalcEngine.TipType(rawValue: tipTypeControl.selectedSegmentIndex)! // Guaranteed return value
        let selectedTotalType = TipCalcEngine.TotalType(rawValue: totalTypeControl.selectedSegmentIndex)! // Guaranteed return value

        if let inputBillAmount = Float(billAmount.text ?? "") {

        totalFor1.text = "\(engine.calculatTotal(totalType: selectedTotalType, billAmount: inputBillAmount, tipType: selectedTipType))"

        }
    }

}

